# typed: strict
# frozen_string_literal: true

class Photonvision < Formula
  desc "Free, fast, and easy-to-use computer vision for FRC"
  homepage "https://photonvision.org/"
  url "https://github.com/PhotonVision/photonvision/archive/refs/tags/v2026.1.1-rc-2.tar.gz"
  sha256 "920c7827177671ca60fafda6c60cc2a823e08b8c260b2c1a3419b010abbe6365"
  license "GPL-3.0-or-later"
  head "https://github.com/PhotonVision/photonvision.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+(?:-(?:alpha|beta|rc)(?:[.-]?\d+)?)?)$/i)
  end

  depends_on "node" => :build
  depends_on "pnpm" => :build
  depends_on "openjdk@17"

  def install
    # Determine architecture override for Gradle
    arch_override = Hardware::CPU.arm? ? "macarm64" : "macx64"

    # Set JAVA_HOME for Gradle
    ENV["JAVA_HOME"] = Formula["openjdk@17"].opt_prefix

    # Patch config.gradle to disable warnings-as-errors
    # WPILib's native-utils passes linker flags during compilation which triggers
    # -Wunused-command-line-argument warnings. Combined with -Werror, this fails the build.
    inreplace "shared/config.gradle",
              "nativeUtils.wpi.addWarningsAsErrors()",
              "// nativeUtils.wpi.addWarningsAsErrors()"

    # Build the fat JAR (photon-targeting:jar builds the native JNI libraries)
    system "./gradlew", "photon-targeting:jar", "photon-server:shadowJar",
           "-PArchOverride=#{arch_override}",
           "--no-daemon"

    # Find and install the built JAR
    jar = Dir["photon-server/build/libs/photonvision-*-#{arch_override}.jar"].first
    libexec.install jar => "photonvision.jar"

    # Create wrapper script
    (bin/"photonvision").write <<~EOS
      #!/bin/bash
      exec "#{Formula["openjdk@17"].opt_bin}/java" -jar "#{libexec}/photonvision.jar" "$@"
    EOS
  end

  def caveats
    <<~EOS
      PhotonVision requires a camera to be connected for full functionality.
      Run with: photonvision
      Then open http://localhost:5800 in your browser.
    EOS
  end

  test do
    assert_match "smoketest complete", shell_output("#{bin}/photonvision --smoketest 2>&1")
  end
end
