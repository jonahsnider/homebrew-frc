cask "corvus" do
  version "26.1.0"
  sha256 "bb119c4137c2f890dcc4da5f1cfff4b6d10a95a472bfc804b3f78b13313446e8"

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
