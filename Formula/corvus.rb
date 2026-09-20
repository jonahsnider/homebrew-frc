class Corvus < Formula
  desc "Generate mechanisms for CTR Electronics devices"
  homepage "https://docs.ctr-electronics.com/cli-tools"
  url "https://redist.ctr-electronics.com/tools/corvus/26.70.0/corvus-26.70.0-macosuniversal"
  sha256 "7d0111864218007cb731a52f21c4d4c9e21543f001539a6eb92b28db51719469"

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


  on_linux do
    on_intel do
      url "https://redist.ctr-electronics.com/tools/corvus/26.70.0/corvus-26.70.0-linuxx86-64?version=26.70.0"
      sha256 "aa95e7ece6e966cf3d922a16811c456d44d69555179e19d21860ed9b2563d457"
    end

    on_arm do
      url "https://redist.ctr-electronics.com/tools/corvus/26.70.0/corvus-26.70.0-linuxarm64?version=26.70.0"
      sha256 "010b658b1476c1e6cdab10fb992c0f6589a25a6f56dfaa05027cbd7305357379"
    end
  end

  def install
    if OS.mac?
      bin.install "corvus-#{version}-macosuniversal" => "corvus"
    elsif Hardware::CPU.intel?
      bin.install "corvus-#{version}-linuxx86-64" => "corvus"
    elsif Hardware::CPU.arm?
      bin.install "corvus-#{version}-linuxarm64" => "corvus"
    end
  end

  test do
    assert_predicate bin/"corvus", :executable?
  end
end
