class Owlet < Formula
  desc "Convert CTR Electronics hoot (.hoot) files into other logging file formats"
  homepage "https://docs.ctr-electronics.com/cli-tools"
  url "https://redist.ctr-electronics.com/tools/owlet/26.2.0/owlet-26.2.0-macosuniversal"
  sha256 "25d4af7022d6bb56b8d8a889fbb814d62cf370b59d560df46de5c72b4979277d"

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

  depends_on :macos

  def install
    bin.install "owlet-#{version}-macosuniversal" => "owlet"
  end

  test do
    assert_predicate bin/"owlet", :executable?
  end
end
