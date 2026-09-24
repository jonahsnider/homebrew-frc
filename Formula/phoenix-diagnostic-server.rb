class PhoenixDiagnosticServer < Formula
  desc "Allow Phoenix Tuner to manage CTR Electronics devices"
  homepage "https://docs.ctr-electronics.com/cli-tools"
  url "https://redist.ctr-electronics.com/tools/PhoenixDiagnosticsProgram/26.3.0/PhoenixDiagnosticsProgram-26.3.0-linuxx86-64?version=26.3.0"
  sha256 "c506fb0acc694015ac6f52f8385ae36965c011ba19fb4d5d6072181624ea846a"
  version_scheme 1

  livecheck do
    url "https://redist.ctr-electronics.com/index.json"
    strategy :json do |json|
      json["Tools"]&.find { |t| t["Name"] == "PhoenixDiagnosticsProgram" }&.dig("Items")&.filter_map do |item|
        next unless %w[linuxx86-64 linuxarm64].all? { |platform| item["Urls"]&.key?(platform) }

        version = item["Version"]
        next if version&.match?(/alpha|beta/i)

        version
      end
    end
  end

  depends_on :linux

  on_linux do
    on_arm do
      url "https://redist.ctr-electronics.com/tools/PhoenixDiagnosticsProgram/26.3.0/PhoenixDiagnosticsProgram-26.3.0-linuxarm64?version=26.3.0"
      sha256 "5125f84cbca6022e2fb0e12cbbb601a7f7f34be4e121581e62e5a9973e92de16"
    end
  end

  def install
    platform = Hardware::CPU.intel? ? "linuxx86-64" : "linuxarm64"
    bin.install "PhoenixDiagnosticsProgram-#{version}-#{platform}" => "phoenix-diagnostic-server"
  end

  test do
    assert_predicate bin/"phoenix-diagnostic-server", :executable?
  end
end
