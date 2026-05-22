class Passerine < Formula
  desc "Convert MIDI files into CTR Electronics CHRP (.chrp) files"
  homepage "https://docs.ctr-electronics.com/cli-tools"
  url "https://redist.ctr-electronics.com/tools/passerine/0.0.1/passerine-0.0.1-macosuniversal"
  sha256 "801855cd2bcfaecb3bb3e6bff3a09d193a3a15191637de915f36b0d86e210d6f"

  livecheck do
    url "https://redist.ctr-electronics.com/index.json"
    strategy :json do |json|
      json["Tools"]&.find { |t| t["Name"] == "passerine" }&.dig("Items")&.filter_map do |item|
        next unless item["Urls"]&.key?("macosuniversal")

        version = item["Version"]
        next if version&.match?(/alpha|beta/i)

        version
      end
    end
  end

  on_linux do
    on_intel do
      url "https://redist.ctr-electronics.com/tools/passerine/0.0.1/passerine-0.0.1-linuxx86-64"
      sha256 "4eb2b763163d0def9191d6842c8f73d4d9cb7d7b24cbd6c5aaba9e2ffebb2f44"
    end

    on_arm do
      url "https://redist.ctr-electronics.com/tools/passerine/0.0.1/passerine-0.0.1-linuxarm64"
      sha256 "82aa1e476ae65b0569bcc0e21cef24fb735deeb9ed74c12d160f22451b191440"
    end
  end

  def install
    if OS.mac?
      bin.install "passerine-#{version}-macosuniversal" => "passerine"
    elsif Hardware::CPU.intel?
      bin.install "passerine-#{version}-linuxx86-64" => "passerine"
    elsif Hardware::CPU.arm?
      bin.install "passerine-#{version}-linuxarm64" => "passerine"
    end
  end

  test do
    assert_predicate bin/"passerine", :executable?
  end
end
