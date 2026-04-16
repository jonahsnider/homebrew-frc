cask "owlet" do
  version "26.1.3"
  sha256 "8443bbeeb8990c5feca2adfadc8266818d10815df6a2a35f3fa88d3145572ac4"

  url "https://redist.ctr-electronics.com/tools/owlet/#{version}/owlet-#{version}-macosuniversal"
  name "Owlet"
  desc "Convert CTR Electronics hoot (.hoot) files into other logging file formats"
  homepage "https://docs.ctr-electronics.com/cli-tools"

  livecheck do
    url "https://redist.ctr-electronics.com/index.json"
    strategy :json do |json|
      json["Tools"]&.find { |t| t["Name"] == "owlet" }&.dig("Items")&.filter_map do |item|
        next unless item["Urls"]&.key?("macosuniversal")

        version = item["Version"]
        next if version&.match?(/alpha|beta/i)

        version
      end
    end
  end

  binary "owlet-#{version}-macosuniversal", target: "owlet"
end
