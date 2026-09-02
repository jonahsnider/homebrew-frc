cask "first-driver-station" do
  arch arm: "arm64", intel: "x64"

  version "2027.0.0-alpha-7"

  on_macos do
    sha256 "5dba7a37f6022b8e9146b0e5a541334fe8474fd41deb924c8dfa80590f6cedec"

    url "https://github.com/wpilibsuite/FirstDriverStation-Public/releases/download/v#{version}/FirstDriverStation-macOS-#{version}.pkg"
  end
  on_macos do
    pkg "FirstDriverStation-macOS-#{version}.pkg"

    uninstall pkgutil: "org.wpilib.firstdriverstation"

    zap trash: "~/Library/Preferences/org.wpilib.firstdriverstation.plist"
  end
  on_linux do
    sha256 arm64_linux:  "0f11f558db3a5c92c73e0d07075a5a3fcfb4c3cfa5a64f988fc0416570c7937d",
           x86_64_linux: "70a9eef1915ef10a85114d8305e94b026b1de95bd85e06f82dffd0186fb9146c"

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
