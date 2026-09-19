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

  bottle do
    root_url "https://github.com/jonahsnider/homebrew-frc/releases/download/corvus-26.50.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "390c6507ae4bd6a5412c89f5165aade82506b3756449e4983c44fa0c8cec49fb"
    sha256 cellar: :any_skip_relocation, sequoia:     "1d4b4c08a0f91bf63a05e231bab9e223127fd3312bd2d662f58524fffdeb1e6c"
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
