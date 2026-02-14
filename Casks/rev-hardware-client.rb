cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.0.6"
  sha256 arm:   "8a0e7abcae122cb382fb66294894e413bc19779a6e820cfcee57eb63304b4088",
         intel: "b2a4b312ec512bffd1a922a9dfe6b3998efd74e6f2201a6321f6703af52705d4"

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
