class Corvus < Formula
  desc "Generate mechanisms for CTR Electronics devices"
  homepage "https://docs.ctr-electronics.com/cli-tools"
  url "https://redist.ctr-electronics.com/tools/corvus/26.1.3/corvus-26.1.3-macosuniversal"
  sha256 "f7a5d2284370f799174dca599ed564e5a6423a92a26285a40d73a01d4fe39962"

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

  depends_on :macos

  def install
    bin.install "corvus-#{version}-macosuniversal" => "corvus"
  end

  test do
    assert_predicate bin/"corvus", :executable?
  end
end
