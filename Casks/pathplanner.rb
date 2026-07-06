cask "pathplanner" do
  version "2026.1.2"

  on_macos do
    sha256 "2bb90f73e00baff8a4b4608330a45c022ccc39b866e70b25eea638d3e3db201c"

    url "https://github.com/mjansen4857/pathplanner/releases/download/v#{version}/PathPlanner-macOS-v#{version}.dmg",
        verified: "github.com/mjansen4857/pathplanner/"
  end

  on_linux do
    sha256 "9f41e49d9ba2a3c445c1a32dbc13c49489e3013c74eefced1bd963eb50ad8b55"

    url "https://github.com/mjansen4857/pathplanner/releases/download/v#{version}/PathPlanner-Linux-v#{version}.zip",
        verified: "github.com/mjansen4857/pathplanner/"
  end

  name "PathPlanner"
  desc "Simple yet powerful path planning tool for FRC robots"
  homepage "https://pathplanner.dev/home.html"

  conflicts_with cask: "pathplanner@2025"

  on_macos do
    # From https://github.com/mjansen4857/pathplanner/blob/main/macos/Podfile
    depends_on macos: :catalina

    app "PathPlanner.app"

    zap trash: [
      "~/Library/Application Support/com.mjansen4857.pathplanner",
      "~/Library/Preferences/com.mjansen4857.pathplanner.plist",
    ]
  end

  on_linux do
    depends_on arch: :x86_64

    binary "pathplanner"
  end
end
