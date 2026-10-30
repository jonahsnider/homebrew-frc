cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.4.4"
  sha256 arm:   "406969340c991327cede91dd92f499b2c51fb405cb4780dfd76c11301ace7244",
         intel: "0b0be4e2c6c3d37e8e65595f4a1b9b60a18015dca1215dfdacc15cf7f1a3f3bd"

  url "https://rhc2.revrobotics.com/download/rev-hardware-client-#{version}-mac-#{arch}.zip"
  name "REV Hardware Client 2"
  desc "Configuration and firmware update utility for REV Robotics hardware"
  homepage "https://revrobotics.com/"

  livecheck do
    url "https://rhc2.revrobotics.com/download/appcast-#{arch}.rss"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: :sequoia

  app "REV Hardware Client 2.app"

  zap trash: "~/Library/Application Support/REV Robotics REV Hardware Client 2"
end
