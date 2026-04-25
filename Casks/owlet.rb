cask "owlet" do
  version "26.2.0"
  sha256 "25d4af7022d6bb56b8d8a889fbb814d62cf370b59d560df46de5c72b4979277d"

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
