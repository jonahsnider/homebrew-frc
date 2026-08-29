cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.4.1"
  sha256 arm:   "1d57969582d4fe67d5333b6223343ef1c39db7f4b054e2a37ae18db70dc610db",
         intel: "ca37bf11a43de7c62e2cc6206897c4620a2090e5926d5d8d52604ccba4e28b55"

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
