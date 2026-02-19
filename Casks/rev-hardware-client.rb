cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.0.7"
  sha256 arm:   "9e1239fe777501c136c6c5a76e7108c3c3ad95d238be6a19c874949da4a43af9",
         intel: "6af0bca2afbef9f6aa4022c4f03b006251a3df09b761006140c751f9d1c9c547"

  url "https://rhc2.revrobotics.com/download/rev-hardware-client-#{version}-mac-#{arch}.zip"
  name "REV Hardware Client 2"
  desc "Configuration and firmware update utility for REV Robotics hardware"
  homepage "https://revrobotics.com/"

  livecheck do
    url "https://rhc2.revrobotics.com/download/appcast-#{arch}.rss"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: ">= :sequoia"

  app "REV Hardware Client 2.app"
end
