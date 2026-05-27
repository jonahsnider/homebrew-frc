cask "pathplanner@2025" do
  version "2025.2.2"
  sha256 "6382af6400f46a8e616d8847a86b9500ac16f2382c44dfdb03bcc4f547b6014e"

  url "https://github.com/mjansen4857/pathplanner/releases/download/v#{version}/PathPlanner-macOS-v#{version}.dmg",
      verified: "github.com/mjansen4857/pathplanner/"
  name "PathPlanner"
  desc "Simple yet powerful path planning tool for FRC robots"
  homepage "https://pathplanner.dev/home.html"

  livecheck do
    url :url
    regex(/^v?(2025(?:\.\d+)+)$/i)
  end

  conflicts_with cask: "pathplanner"
  # From https://github.com/mjansen4857/pathplanner/blob/main/macos/Podfile
  depends_on macos: :catalina

  app "PathPlanner.app"

  zap trash: [
    "~/Library/Application Support/com.mjansen4857.pathplanner",
    "~/Library/Preferences/com.mjansen4857.pathplanner.plist",
  ]
end
