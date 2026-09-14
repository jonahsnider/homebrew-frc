cask "first-driver-station" do
  arch arm: "arm64", intel: "x64"

  version "2027.0.0-alpha-8"

  on_macos do
    sha256 "63458b38c5eb95908b797061a5a593ef534115384812bce9379cb6383b457e0d"

    url "https://github.com/wpilibsuite/FirstDriverStation-Public/releases/download/v#{version}/FirstDriverStation-macOS-#{version}.pkg"
  end
  on_macos do
    pkg "FirstDriverStation-macOS-#{version}.pkg"

    uninstall pkgutil: "org.wpilib.firstdriverstation"

    zap trash: "~/Library/Preferences/org.wpilib.firstdriverstation.plist"
  end
  on_linux do
    sha256 arm64_linux:  "0280842fb55f4f8b489c6a11776b4007df29b984a42c76611fa26d9f05686083",
           x86_64_linux: "abc006cc9b6a901977838838377a665a96b102f19aedeb4a168ebc6726e73506"

    url "https://github.com/wpilibsuite/FirstDriverStation-Public/releases/download/v#{version}/FirstDriverStation-linux-#{arch}-#{version}.tar.gz"
  end
  on_linux do
    binary "FirstDriverStation", target: "first-driver-station"
  end

  name "FIRST Driver Station"
  desc "Driver station for the FIRST Robotics Competition"
  homepage "https://github.com/wpilibsuite/FirstDriverStation-Public"

  livecheck do
    url :url
  end
end
