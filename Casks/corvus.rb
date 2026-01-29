cask "corvus" do
  version "26.1.1"
  sha256 "a10ccf545056b51a12a2b6cae302f2c7e491233ed7ecfe2b22b9a07a41afd7d9"

  url "https://redist.ctr-electronics.com/tools/corvus/#{version}/corvus-#{version}-macosuniversal"
  name "Corvus"
  desc "Generate mechanisms for CTR Electronics devices"
  homepage "https://docs.ctr-electronics.com/cli-tools"

  livecheck do
    url "https://redist.ctr-electronics.com/index.json"
    strategy :json do |json|
      json["Tools"]&.find { |t| t["Name"] == "corvus" }&.dig("Items")&.filter_map do |item|
        next unless item["Urls"]&.key?("macosuniversal")

        version = item["Version"]
        next if version&.match?(/alpha|beta/i)

        version
      end
    end
  end

  binary "corvus-#{version}-macosuniversal", target: "corvus"
end
