class Passerine < Formula
  desc "Convert MIDI files into CTR Electronics CHRP (.chrp) files"
  homepage "https://docs.ctr-electronics.com/cli-tools"
  url "https://redist.ctr-electronics.com/tools/passerine/1.0.0/passerine-1.0.0-macosuniversal"
  sha256 "35573fb482f81ef50e67d066b77afd3c78461d556b78cc026072fa8f2d5e31b0"
  version_scheme 1

  livecheck do
    url "https://redist.ctr-electronics.com/index.json"
    strategy :json do |json|
      json["Tools"]&.find { |t| t["Name"] == "passerine" }&.dig("Items")&.filter_map do |item|
        next unless %w[macosuniversal linuxx86-64 linuxarm64].all? { |platform| item["Urls"]&.key?(platform) }

        version = item["Version"]
        next if version&.match?(/alpha|beta/i)

        version
      end
    end
  end

  bottle do
    root_url "https://github.com/jonahsnider/homebrew-frc/releases/download/passerine-1.0.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "deceff86a516fdba662b268c53b3f3cf113c8ec7a015ec3a84b196fa04fa73c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "06597a0223bb8ee965165372b2696989ddcfc0147fc5a24c41414ddd6accca61"
  end

  on_linux do
    on_intel do
      url "https://redist.ctr-electronics.com/tools/passerine/1.0.0/passerine-1.0.0-linuxx86-64?version=1.0.0"
      sha256 "16f8546cb54798b40be3e985e6134f6355cd962b5909e8699d5b388a3a51b8c4"
    end

    on_arm do
      url "https://redist.ctr-electronics.com/tools/passerine/1.0.0/passerine-1.0.0-linuxarm64?version=1.0.0"
      sha256 "7a249af07af0e7034aa870e7fe7e17b7f25e52a5d011c31d12913b1bb108fb77"
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
