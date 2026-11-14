cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.4.6"
  sha256 arm:   "10ae8cc75b95ab68c443dd053e25fa5a5196b3b7deaa9213a2a601838689b289",
         intel: "f507285d2a05cfc80d94934a5b6d43cae11d11fd088fc5895af6cc2b90941dda"

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
