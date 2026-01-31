cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.0.4"
  sha256 arm:   "8591550190c5f72db6e729b02e5ca58fea0d034d541427633fd2e86848c62d72",
         intel: "c571c36bb8204a6649e77db1345bab9b03332478bf726d18cdb11d4c3b337cc9"

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
