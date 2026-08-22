cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.4.0"
  sha256 arm:   "5d2dcf1c4ec5230c5edeb953aba8fae682aa9a6a23a68af7383faec7904362f9",
         intel: "2750affca3170e69d6de37f638e13741b466d966cc819dc265e80fceb25c6968"

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
