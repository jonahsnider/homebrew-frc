cask "pathplanner" do
  version "2026.1.2"
  sha256 "2bb90f73e00baff8a4b4608330a45c022ccc39b866e70b25eea638d3e3db201c"

  url "https://github.com/mjansen4857/pathplanner/releases/download/v#{version}/PathPlanner-macOS-v#{version}.dmg",
      verified: "github.com/mjansen4857/pathplanner/"
  name "PathPlanner"
  desc "Simple yet powerful path planning tool for FRC robots"
  homepage "https://pathplanner.dev/home.html"

  livecheck do
    url :url
    strategy :git do |tags|
      tags.map { |tag| tag.delete_prefix("v") }
    end
  end

  # From https://github.com/mjansen4857/pathplanner/blob/main/macos/Podfile
  depends_on macos: ">= :catalina"

  app "PathPlanner.app"

  zap trash: [
    "~/Library/Application Support/com.mjansen4857.pathplanner",
    "~/Library/Preferences/com.mjansen4857.pathplanner.plist",
  ]
end
