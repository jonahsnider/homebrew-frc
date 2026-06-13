class Corvus < Formula
  desc "Generate mechanisms for CTR Electronics devices"
  homepage "https://docs.ctr-electronics.com/cli-tools"
  url "https://redist.ctr-electronics.com/tools/corvus/26.50.0/corvus-26.50.0-macosuniversal"
  sha256 "901b3bfd046b3319889b30f1c399e6f6b16feb0350b98d9969970b9b26debc55"

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
      url "https://redist.ctr-electronics.com/tools/corvus/26.1.3/corvus-26.1.3-linuxx86-64"
      sha256 "43362684b40402205fa2027da231ef1c0b59b86ecdb0cec6a3e220739c462356"
    end

    on_arm do
      url "https://redist.ctr-electronics.com/tools/corvus/26.1.3/corvus-26.1.3-linuxarm64"
      sha256 "2c61646cffbf8431db50dd370772a90c30a0a44bd95d21f04b622f77632bf063"
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
