cask "first-driver-station" do
  version "2027.0.0-alpha-4"
  sha256 "ea0952180e577ee888c65a58dfa04d1aa63c1085a90a0b11f79fa77f6cd060e9"

  url "https://github.com/wpilibsuite/FirstDriverStation-Public/releases/download/v#{version}/FirstDriverStation-macOS-universal-#{version}.pkg"
  name "FIRST Driver Station"
  desc "Driver station for the FIRST Robotics Competition"
  homepage "https://github.com/wpilibsuite/FirstDriverStation-Public"

  livecheck do
    url :url
  end

  depends_on :macos

  pkg "FirstDriverStation-macOS-universal-#{version}.pkg"

  uninstall pkgutil: "org.wpilib.firstdriverstation"

  zap trash: "~/Library/Preferences/org.wpilib.firstdriverstation.plist"
end
