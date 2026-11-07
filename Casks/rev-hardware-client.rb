cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.4.5"
  sha256 arm:   "d10ab54e59d8a0c68a0dc394701a02fe788c2e5b49c980e22fea79346fa9f593",
         intel: "9c3788b03e7de74daa624c54aa38e81ec7347a9f9bbd88339ff9c6c360573226"

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
