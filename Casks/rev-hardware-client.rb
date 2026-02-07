cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.0.5"
  sha256 arm:   "32c9e7f4fea32e2f274656be1a2ce5bacce6d7d4c1a65687df7e0cbdcb2fc804",
         intel: "df4096464487bf5d0da495e4900a3916db38e2bd4f745db9f8a066184a0efb4a"

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
