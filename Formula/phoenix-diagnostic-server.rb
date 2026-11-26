class PhoenixDiagnosticServer < Formula
  desc "Allow Phoenix Tuner to manage CTR Electronics devices"
  homepage "https://docs.ctr-electronics.com/cli-tools"
  url "https://redist.ctr-electronics.com/tools/PhoenixDiagnosticsProgram/26.3.1/PhoenixDiagnosticsProgram-26.3.1-linuxx86-64?version=26.3.1"
  sha256 "dbaa53ff0f4db12d6204551e80b1be8be2c8965f1788218539ec955d8866e305"
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
      url "https://redist.ctr-electronics.com/tools/PhoenixDiagnosticsProgram/26.3.1/PhoenixDiagnosticsProgram-26.3.1-linuxarm64?version=26.3.1"
      sha256 "b060da6e7e30151c617d05b3ddab32486ec740495e4145a8b38207a7bf333a7f"
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
