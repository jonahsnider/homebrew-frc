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
  LINUX_PLATFORMS = %w[linuxx86-64 linuxarm64].freeze
  REVISION_OVERRIDES = { "passerine@0.0.1" => 1 }.freeze
  TOOLS = %w[corvus owlet passerine phoenix-diagnostic-server].freeze
  UPSTREAM_NAMES = { "phoenix-diagnostic-server" => "PhoenixDiagnosticsProgram" }.freeze
  VERSION_SCHEME = 1

  class << self
    def formula_path(name)
      File.join(ROOT, "Formula", "#{name}.rb")
    end

    def version_scheme_current?(contents)
      contents.lines(chomp: true).include?("  version_scheme #{VERSION_SCHEME}")
    end

    def formula_revision(contents)
      contents[/^  revision (\d+)$/, 1].to_i
    end

    def platforms(name)
      (name == "phoenix-diagnostic-server") ? LINUX_PLATFORMS : PLATFORMS
    end

    def upstream_name(name)
      UPSTREAM_NAMES.fetch(name, name)
    end

    def formula_assets(name, contents)
      assets = {}

      contents.scan(/^([ \t]*)url "([^"]+)"\n\1sha256 "([0-9a-f]{64})"/) do |indent, url, sha256|
        match = Regexp.last_match
        uri = URI(url)
        prefix = "/tools/#{upstream_name(name)}/"
        next if uri.host != "redist.ctr-electronics.com" || !uri.path.start_with?(prefix)

        version, filename = uri.path.delete_prefix(prefix).split("/", 2)
        platform = platforms(name).find { |candidate| filename == "#{upstream_name(name)}-#{version}-#{candidate}" }
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

      missing = platforms(name) - assets.keys
      raise "#{name}: missing #{missing.join(", ")}" if missing.any?

      assets
    end

    def latest_release(index, name)
      tool = index.fetch("Tools").find { |candidate| candidate["Name"] == upstream_name(name) }
      raise "#{name}: missing from #{INDEX_URL}" unless tool

      releases = tool.fetch("Items").select do |item|
        version = item.fetch("Version")
        next false if version.match?(/alpha|beta/i)

        platforms(name).all? { |platform| item.fetch("Urls", {}).key?(platform) }
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

    def formula_url(url, version, platform)
      return url if platform == "macosuniversal"

      "#{url}?version=#{version}"
    end

    def check
      TOOLS.each do |name|
        contents = File.read(formula_path(name))
        assets = formula_assets(name, contents)
        versions = assets.values.map { |asset| asset.fetch(:version) }.uniq
        raise "#{name}: platform versions differ: #{versions.join(", ")}" unless versions.one?
        raise "#{name}: version_scheme must be #{VERSION_SCHEME}" unless version_scheme_current?(contents)

        expected_revision = REVISION_OVERRIDES.fetch("#{name}@#{versions.first}", 0)
        raise "#{name}: revision must be #{expected_revision}" if formula_revision(contents) != expected_revision

        assets.each do |platform, asset|
          next if platform == "macosuniversal"

          query_version = URI.decode_www_form(URI(asset.fetch(:url)).query.to_s).to_h["version"]
          next if query_version == versions.first

          raise "#{name}: #{platform} URL must declare version=#{versions.first}"
        end
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
        expected_urls = platforms(name).to_h do |platform|
          [platform, formula_url(release.fetch("Urls").fetch(platform), version, platform)]
        end
        expected_revision = REVISION_OVERRIDES.fetch("#{name}@#{version}", 0)
        urls_current = assets.all? do |platform, asset|
          asset.fetch(:version) == version && asset.fetch(:url) == expected_urls.fetch(platform)
        end
        revision_current = formula_revision(contents) == expected_revision
        next if urls_current && version_scheme_current?(contents) && revision_current

        platforms(name).each do |platform|
          asset = assets.fetch(platform)
          url = expected_urls.fetch(platform)
          replacement = <<~FORMULA.chomp
            #{asset.fetch(:indent)}url "#{url}"
            #{asset.fetch(:indent)}sha256 "#{sha256(url)}"
          FORMULA
          contents.sub!(asset.fetch(:full_match), replacement)
        end

        unless contents.match?(/^  version_scheme /)
          updated = contents.sub!(/^  sha256 "[0-9a-f]{64}"\n/, "\\0  version_scheme #{VERSION_SCHEME}\n")
          raise "#{name}: missing top-level sha256" unless updated
        end

        if expected_revision.zero?
          contents.sub!(/^  revision \d+\n/, "")
        elsif contents.match?(/^  revision \d+$/)
          contents.sub!(/^  revision \d+$/, "  revision #{expected_revision}")
        else
          contents.sub!(/^  version_scheme /, "  revision #{expected_revision}\n\\0")
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
