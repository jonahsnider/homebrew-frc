cask "choreo" do
  arch arm: "aarch64", intel: "x86_64"

  version "2026.0.1"
  sha256 arm:   "eebf0d8afafc331461aae3aec35f37a8625369ba48616f3cdd745283854b84d4",
         intel: "a1275207b8745dc0d319ff07ee4ce480687eb44c6c76610d8a6c0c88daf3318f"

  url "https://github.com/SleipnirGroup/Choreo/releases/download/v#{version}/Choreo-v#{version}-macOS-#{arch}.dmg",
      verified: "github.com/SleipnirGroup/Choreo/"
  name "Choreo"
  desc "Time-optimal drivetrain trajectory planner for the FIRST Robotics Competition"
  homepage "https://choreo.autos/"

  depends_on macos: ">= :sonoma"

  app "Choreo.app"

  zap trash: "~/Library/Application Support/choreo"
end
