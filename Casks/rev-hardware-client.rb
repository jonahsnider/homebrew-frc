cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.4.2"
  sha256 arm:   "fbd3b9614f263ae4f19d9431700f4c9b69ba7bc163d93bd7d8b82f9c81a3b2c8",
         intel: "0c10e7721652ecad54e9d74cf5f2b51007380543d799039761b67e9d7d4d6fc6"

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
