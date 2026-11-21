cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.4.7"
  sha256 arm:   "151585e591a860930543eb93d978c2ac5779083fb0dcc607738ae29d6f845c3d",
         intel: "a6166a097a3bfa92ad3fc0bfdd4d3de4995cdd339f7ae94431fb45334b1acf71"

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
