cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.0.2"
  sha256 arm:   "b6eccd94e73d1ff8afa2a91e1270e4a279e40828f83ee6085b041b1a9dfb2503",
         intel: "5bbbf4e44c28ecf94a33dc66fb92aa147095a9fa5e74b6db69bcfb88bc82c1f1"

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
