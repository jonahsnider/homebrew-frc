class Corvus < Formula
  desc "Generate mechanisms for CTR Electronics devices"
  homepage "https://docs.ctr-electronics.com/cli-tools"
  url "https://redist.ctr-electronics.com/tools/corvus/26.70.0/corvus-26.70.0-macosuniversal"
  sha256 "7d0111864218007cb731a52f21c4d4c9e21543f001539a6eb92b28db51719469"
  version_scheme 1

  livecheck do
    url "https://redist.ctr-electronics.com/index.json"
    strategy :json do |json|
      json["Tools"]&.find { |t| t["Name"] == "corvus" }&.dig("Items")&.filter_map do |item|
        next unless %w[macosuniversal linuxx86-64 linuxarm64].all? { |platform| item["Urls"]&.key?(platform) }

        version = item["Version"]
        next if version&.match?(/alpha|beta/i)

        version
      end
    end
  end

  bottle do
    root_url "https://github.com/jonahsnider/homebrew-frc/releases/download/corvus-26.70.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "8dd7fef8aa63a0de15e198936e5f0235d262dce89793e98279bdf464dd5c0931"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f36d874ae54cc93619f18dacd980ed571691b6d7d438f4594930d2b8298ddbec"
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
