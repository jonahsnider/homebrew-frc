cask "limelight-hardware-manager" do
  arch arm: "AppleSilicon", intel: "Intel"

  version "2.0.7"
  sha256 arm:   "497341631ea53120417dee88659c48fc2a094e0312c2e372ab632ef4f58e4f05",
         intel: "bcafb7dcbc189890794deec7003e2e56fe25f469fba3a29bf2f492f2f86cd84d"

  url "https://downloads.limelightvision.io/software/LimelightHardwareManager-macOS-#{arch}#{version.dots_to_underscores}.dmg"
  name "Limelight Hardware Manager"
  desc "Flash and find Limelight devices"
  homepage "https://limelightvision.io/"

  livecheck do
    url "https://docs.limelightvision.io/docs/resources/downloads"
    strategy :page_match do |page|
      regex = /LimelightHardwareManager-macOS-AppleSilicon(\d+(?:_\d+)+)\.dmg/i
      versions = page.scan(regex).map { |m| m.first.tr("_", ".") }

      # The Limelight docs can be stale, so we check the SystemcoreTesting README in case that's more up to date
      begin
        require "open-uri"
        readme = URI.parse(
          "https://raw.githubusercontent.com/wpilibsuite/SystemcoreTesting/main/README.md",
        ).open.read
        versions.concat(readme.scan(regex).map { |m| m.first.tr("_", ".") })
      rescue
        nil
      end

      versions.uniq
    end
  end

  depends_on :macos

  app "Limelight Hardware Manager.app"

  zap trash: "~/Library/Preferences/com.limelight.hardwaremanager.plist"
end
