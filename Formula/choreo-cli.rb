class ChoreoCli < Formula
  desc "CLI for Choreo, a time-optimal FRC drivetrain trajectory planner"
  homepage "https://choreo.autos/"
  url "https://github.com/SleipnirGroup/Choreo/archive/refs/tags/v2026.0.3.tar.gz"
  sha256 "0bec28500a669b47ee7afc3cefc06de2fa6acbca20d4f6b0a920ed4262e710f0"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/jonahsnider/homebrew-frc/releases/download/choreo-cli-2026.0.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "cbe155c1afe254f6a79d9cd9e00bfb7064752e0bdef3cc9bfd4a07c70cabddaa"
    sha256 cellar: :any,                 x86_64_linux: "1913d919216a675f95b019854007f3a2809b8844dca98260e1ea0d8bfa8ede04"
  end

  depends_on "cmake" => :build
  depends_on "rust" => :build

  on_linux do
    depends_on "gcc@14" => :build if DevelopmentTools.gcc_version < 14
  end

  fails_with :gcc do
    version "13"
    cause "Requires C++23 <print>"
  end

  def install
    if OS.linux? && deps.map(&:name).any?("gcc@14")
      ENV.method(:"gcc-14").call

      libgcc = Pathname.new(Utils.safe_popen_read(ENV.cc, "-print-libgcc-file-name")).parent
      ENV.append "CXX", "-specs=#{libgcc}/specs.orig"
    end

    system "cargo", "install", *std_cargo_args(path: "src-cli")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/choreo-cli --version")
  end
end
