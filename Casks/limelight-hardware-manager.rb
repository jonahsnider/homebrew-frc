cask "limelight-hardware-manager" do
  arch arm: "AppleSilicon", intel: "Intel"

  version "2.0.6"
  sha256 arm:   "5f8100ff853680a047ed14b232617fd80887f94d94a698daf70c6e3052dc3c2d",
         intel: "a452b62b96b914257480ead5d8a4f52c2ed930092acf88f59d9d3bcaa33309d2"

  url "https://downloads.limelightvision.io/software/LimelightHardwareManager-macOS-#{arch}#{version.dots_to_underscores}.dmg"
  name "Limelight Hardware Manager"
  desc "Flash and find Limelight devices"
  homepage "https://limelightvision.io/"

  livecheck do
    url "https://docs.limelightvision.io/docs/resources/downloads"
    regex(/Limelight\s+Hardware\s+Manager\s+(\d+(?:\.\d+)+)\s*-\s*APPLE\s+SILICON/i)
  end

  app "Limelight Hardware Manager.app"
end
