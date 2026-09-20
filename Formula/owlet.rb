class Owlet < Formula
  desc "Convert CTR Electronics hoot (.hoot) files into other logging file formats"
  homepage "https://docs.ctr-electronics.com/cli-tools"
  url "https://redist.ctr-electronics.com/tools/owlet/26.70.0/owlet-26.70.0-macosuniversal"
  sha256 "fcdc1f6fd51758ecc6bc9d5a7bd5b201a35518904c94db44e1a2c7f5b40359a2"
  version_scheme 1

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

  bottle do
    root_url "https://github.com/jonahsnider/homebrew-frc/releases/download/owlet-26.70.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "238acc26922dd12432501a7f8affc0fa4fd39f38abe0196ce874368e6fb58378"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bdaff24832ce47899b55f5795e8e8c77403c755ac850e1ce96e48cc287c5ab5b"
  end

  on_linux do
    on_intel do
      url "https://redist.ctr-electronics.com/tools/owlet/26.70.0/owlet-26.70.0-linuxx86-64?version=26.70.0"
      sha256 "081b0a122296fd12e845553f161446fefe16891f0bdc44d8679edb4785a99baa"
    end

    on_arm do
      url "https://redist.ctr-electronics.com/tools/owlet/26.70.0/owlet-26.70.0-linuxarm64?version=26.70.0"
      sha256 "37efd5519ca9b017b9cc0242e4c0a531400566566415865751012feb84059adc"
    end
  end

  def install
    if OS.mac?
      bin.install "owlet-#{version}-macosuniversal" => "owlet"
    elsif Hardware::CPU.intel?
      bin.install "owlet-#{version}-linuxx86-64" => "owlet"
    elsif Hardware::CPU.arm?
      bin.install "owlet-#{version}-linuxarm64" => "owlet"
    end
  end

  test do
    assert_predicate bin/"owlet", :executable?
  end
end
