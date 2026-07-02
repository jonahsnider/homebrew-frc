cask "first-driver-station" do
  version "2027.0.0-alpha-6"
  sha256 "2034467bc198d8c20c01fd74b8556cf6f813785c75c15f6398e3def60adcc883"

  url "https://github.com/wpilibsuite/FirstDriverStation-Public/releases/download/v#{version}/FirstDriverStation-macOS-#{version}.pkg"
  name "FIRST Driver Station"
  desc "Driver station for the FIRST Robotics Competition"
  homepage "https://github.com/wpilibsuite/FirstDriverStation-Public"

  livecheck do
    url :url
  end

  depends_on :macos

  pkg "FirstDriverStation-macOS-#{version}.pkg"

  uninstall pkgutil: "org.wpilib.firstdriverstation"

  zap trash: "~/Library/Preferences/org.wpilib.firstdriverstation.plist"
end
