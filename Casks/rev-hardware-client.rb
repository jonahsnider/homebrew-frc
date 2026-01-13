cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.0.0"
  sha256 arm:   "c0256fe7f6c3cce975875319e254e3787bacefc9134909e8d82bdf5420fcf18d",
         intel: "9ea4070c26f1465bff88f02ea42a5374a47ddfa35a764a9de1e9ce43b9772eaa"

  url "https://rhc2.revrobotics.com/download/rev-hardware-client-#{version}-mac-#{arch}.zip"
  name "REV Hardware Client 2"
  desc "Configuration and firmware update utility for REV Robotics hardware"
  homepage "https://revrobotics.com/"

  livecheck do
    url "https://rhc2.revrobotics.com/download/appcast-#{arch}.rss"
    strategy :sparkle, &:short_version
  end

  auto_updates true

  app "REV Hardware Client 2.app"
end
