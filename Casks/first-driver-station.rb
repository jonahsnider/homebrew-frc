cask "first-driver-station" do
  version "2027.0.0-alpha-5"
  sha256 "bde42d62bf9948fe86dd50aadf01986dd250138cb0192b161f1d3a26dc7d16de"

  url "https://github.com/wpilibsuite/FirstDriverStation-Public/releases/download/v#{version}/FirstDriverStation-macOS-#{version}.pkg"
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
