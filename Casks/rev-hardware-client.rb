cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.4.3"
  sha256 arm:   "2c45dc7ba0206165dc134b2f5b83aeb6b713e7da447720fe04a04e03951561aa",
         intel: "2641bc676371b3e88aaa0d0d1ae914d717812b2826ae94ebe5a2b2299b559c40"

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
