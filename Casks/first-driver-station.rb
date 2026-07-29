cask "first-driver-station" do
  arch arm: "arm64", intel: "x64"

  version "2027.0.0-alpha-6"

  on_macos do
    sha256 "2034467bc198d8c20c01fd74b8556cf6f813785c75c15f6398e3def60adcc883"

    url "https://github.com/wpilibsuite/FirstDriverStation-Public/releases/download/v#{version}/FirstDriverStation-macOS-#{version}.pkg"
  end
  on_macos do
    pkg "FirstDriverStation-macOS-#{version}.pkg"

    uninstall pkgutil: "org.wpilib.firstdriverstation"

    zap trash: "~/Library/Preferences/org.wpilib.firstdriverstation.plist"
  end
  on_linux do
    sha256 arm64_linux:  "715db59ba6386cb167fb8c0cf9b5e10e3fc61fb26a29c8b307d95f8e127d9e37",
           x86_64_linux: "69e2015bd382c4a9264d998ca7a45a4d73b2a917fe11192beec6234fafcdbff6"

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
