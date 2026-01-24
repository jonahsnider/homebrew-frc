cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.0.3"
  sha256 arm:   "45aee80f11cf859528fa3a8ecd8e3ed7899672981ca8f2fca2aba494aba83e52",
         intel: "6ceb80c3722f186ea0d6e4e22a1f85e47edc72a86ec27c5aad9a3cb17f85ac97"

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
