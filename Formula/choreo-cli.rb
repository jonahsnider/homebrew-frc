class ChoreoCli < Formula
  desc "CLI for Choreo, a time-optimal FRC drivetrain trajectory planner"
  homepage "https://choreo.autos/"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/SleipnirGroup/Choreo/releases/download/v2026.0.3/Choreo-v2026.0.3-macOS-aarch64-standalone.zip",
          verified: "github.com/SleipnirGroup/Choreo/"
      sha256 "df9bf5c383d129bcb2965c97f1f3c9bb1ece553a28a190a605edb457df308e12"
    end

    on_intel do
      url "https://github.com/SleipnirGroup/Choreo/releases/download/v2026.0.3/Choreo-v2026.0.3-macOS-x86_64-standalone.zip",
          verified: "github.com/SleipnirGroup/Choreo/"
      sha256 "4b0f1836f26ec75bf14b08820b55f9be7fe9dd711df76ec11a397917bc4295f5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/SleipnirGroup/Choreo/releases/download/v2026.0.3/Choreo-v2026.0.3-Linux-aarch64-standalone.zip",
          verified: "github.com/SleipnirGroup/Choreo/"
      sha256 "28315c728117725dea4bb16212eda47946aafe98f04f9b5e073b295a12a4ac91"
    end

    on_intel do
      url "https://github.com/SleipnirGroup/Choreo/releases/download/v2026.0.3/Choreo-v2026.0.3-Linux-x86_64-standalone.zip",
          verified: "github.com/SleipnirGroup/Choreo/"
      sha256 "e70d421d067ed3faeaeae4ad537ab7e82eabce98354e694820b612190ab1de4b"
    end
  end

  def install
    bin.install "choreo-cli"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/choreo-cli --version")
  end
end
