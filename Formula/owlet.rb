class Owlet < Formula
  desc "Convert CTR Electronics hoot (.hoot) files into other logging file formats"
  homepage "https://docs.ctr-electronics.com/cli-tools"
  url "https://redist.ctr-electronics.com/tools/owlet/26.3.0/owlet-26.3.0-macosuniversal"
  sha256 "31f2237952c6783427cef11a41985057f2ab64ea30f4beda082bc9f3ae37b089"

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

  on_linux do
    on_intel do
      url "https://redist.ctr-electronics.com/tools/owlet/26.2.0/owlet-26.2.0-linuxx86-64"
      sha256 "465745e395bd7474092b55b222d6ff12aa137873a553c446c76b5dea492c5ac4"
    end

    on_arm do
      url "https://redist.ctr-electronics.com/tools/owlet/26.2.0/owlet-26.2.0-linuxarm64"
      sha256 "61187892eb6c5dc894fbc39ab074ff1d11604b90b3c29ad134385ce8e0699ec8"
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
