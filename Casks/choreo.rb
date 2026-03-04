cask "choreo" do
  arch arm: "aarch64", intel: "x86_64"

  version "2026.0.2"
  sha256 arm:   "63d5c6240a64be31dcc295b02c01b85b441bc1e1a4b80a6290fb520ad60e58a0",
         intel: "4350c701633aa6e00829eeb3ece1a94a3cc2b9be70cb6eb96b8d3203aed02f98"

  url "https://github.com/SleipnirGroup/Choreo/releases/download/v#{version}/Choreo-v#{version}-macOS-#{arch}.dmg",
      verified: "github.com/SleipnirGroup/Choreo/"
  name "Choreo"
  desc "Time-optimal drivetrain trajectory planner for the FIRST Robotics Competition"
  homepage "https://choreo.autos/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Choreo.app"

  zap trash: "~/Library/Application Support/choreo"
end
