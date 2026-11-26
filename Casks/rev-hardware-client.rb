cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.5.0"
  sha256 arm:   "605a68a129ec3372cf6132887c5bc5becfc95ae2b15c5d6b6c09957f631da318",
         intel: "07b73e5626f4a9c96ec0ceb9d04eb575f2866cab204339802eac57afa15e552c"

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
