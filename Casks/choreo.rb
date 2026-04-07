cask "choreo" do
  arch arm: "aarch64", intel: "x86_64"

  version "2026.0.3"
  sha256 arm:   "e3855d9ec09c3a335ede5d5e6bcdfcaa94165a195ab33c956a2c2043a15d9bcb",
         intel: "ab7b3cec24cd7599cc389dca7fbf0b38da068b0ee7dd734bdbb7e47bbeaa4de8"

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
