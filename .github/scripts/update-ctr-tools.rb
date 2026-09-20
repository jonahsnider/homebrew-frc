# frozen_string_literal: true

require "digest"
require "json"
require "net/http"
require "rubygems/version"
require "uri"

# Keeps every supported CTR platform on the same stable tool release.
class CtrToolsUpdater
  ROOT = File.expand_path("../..", __dir__).freeze
  INDEX_URL = "https://redist.ctr-electronics.com/index.json"
  PLATFORMS = %w[macosuniversal linuxx86-64 linuxarm64].freeze
  TOOLS = %w[corvus owlet passerine].freeze

  class << self
    def formula_path(name)
      File.join(ROOT, "Formula", "#{name}.rb")
    end

    def formula_assets(name, contents)
      assets = {}

      contents.scan(/^([ \t]*)url "([^"]+)"\n\1sha256 "([0-9a-f]{64})"/) do |indent, url, sha256|
        match = Regexp.last_match
        prefix = "https://redist.ctr-electronics.com/tools/#{name}/"
        next unless url.start_with?(prefix)

        version, filename = url.delete_prefix(prefix).split("/", 2)
        platform = PLATFORMS.find { |candidate| filename == "#{name}-#{version}-#{candidate}" }
        next unless platform

        raise "#{name}: duplicate #{platform} URL" if assets.key?(platform)

        assets[platform] = {
          full_match: match[0],
          indent:,
          sha256:,
          url:,
          version:,
        }
      end

      missing = PLATFORMS - assets.keys
      raise "#{name}: missing #{missing.join(", ")}" if missing.any?

      assets
    end

    def latest_release(index, name)
      tool = index.fetch("Tools").find { |candidate| candidate["Name"] == name }
      raise "#{name}: missing from #{INDEX_URL}" unless tool

      releases = tool.fetch("Items").select do |item|
        version = item.fetch("Version")
        next false if version.match?(/alpha|beta/i)

        PLATFORMS.all? { |platform| item.fetch("Urls", {}).key?(platform) }
      end

      releases.max_by { |item| Gem::Version.new(item.fetch("Version")) } ||
        raise("#{name}: no stable release supports every platform")
    end

    def fetch(url, redirects = 5)
      raise "Too many redirects fetching #{url}" if redirects.zero?

      uri = URI(url)
      request = Net::HTTP::Get.new(uri)
      request["User-Agent"] = "homebrew-frc-updater"
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
        http.request(request)
      end

      case response
      when Net::HTTPSuccess
        response.body
      when Net::HTTPRedirection
        fetch(URI.join(url, response.fetch("location")).to_s, redirects - 1)
      else
        raise "Failed to fetch #{url}: #{response.code} #{response.message}"
      end
    end

    def sha256(url)
      Digest::SHA256.hexdigest(fetch(url))
    end

    def check
      TOOLS.each do |name|
        assets = formula_assets(name, File.read(formula_path(name)))
        versions = assets.values.map { |asset| asset.fetch(:version) }.uniq
        raise "#{name}: platform versions differ: #{versions.join(", ")}" unless versions.one?
      end

      puts "CTR tool platform versions match"
    end

    def update
      index = JSON.parse(fetch(INDEX_URL))
      updates = []

      TOOLS.each do |name|
        path = formula_path(name)
        contents = File.read(path)
        assets = formula_assets(name, contents)
        release = latest_release(index, name)
        version = release.fetch("Version")
        next if assets.values.all? { |asset| asset.fetch(:version) == version }

        PLATFORMS.each do |platform|
          asset = assets.fetch(platform)
          url = release.fetch("Urls").fetch(platform)
          replacement = <<~FORMULA.chomp
            #{asset.fetch(:indent)}url "#{url}"
            #{asset.fetch(:indent)}sha256 "#{sha256(url)}"
          FORMULA
          contents.sub!(asset.fetch(:full_match), replacement)
        end

        contents.sub!(/\n  bottle do\n.*?^  end\n/m, "\n")
        File.write(path, contents)
        updates << "#{name} #{version}"
      end

      write_github_output(updates)
      puts updates.any? ? "Updated #{updates.join(", ")}" : "CTR tools are current"
    end

    def write_github_output(updates)
      output = ENV.fetch("GITHUB_OUTPUT", nil)
      return unless output

      digest = Digest::SHA256.hexdigest(TOOLS.map { |name| File.read(formula_path(name)) }.join)[0, 12]
      File.open(output, "a") do |file|
        file.puts "updated=#{updates.any?}"
        file.puts "branch_suffix=#{digest}"
        file.puts "summary=#{updates.join(", ")}"
      end
    end
  end
end

if ARGV == ["--check"]
  CtrToolsUpdater.check
elsif ARGV.empty?
  CtrToolsUpdater.update
else
  abort "Usage: #{File.basename($PROGRAM_NAME)} [--check]"
end
