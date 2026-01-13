cask "rev-hardware-client" do
  arch arm: "aarch64", intel: "amd64"

  version "1.0.1"
  sha256 arm:   "1e982405128d2093b01f2a08e7f2a94234eb01f360c7b41942d50085f82d3aaf",
         intel: "b77bfa187261de310f21d010f694842aa3486a8743b713a117046b8b03ee90a9"

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
