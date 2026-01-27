cask "owlet" do
  version "26.1.0"
  sha256 "45eaa6155843f7993b88b92ca355aaa133ff4958e9184bbbe9e422040b837126"

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
