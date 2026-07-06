cask "limelight-hardware-manager" do
  arch arm: "AppleSilicon", intel: "Intel"

  version "2.0.10"
  sha256 arm:          "23d208cf628d67b26b0426ecb720a659caf867c6116d2f192462006d0406d79b",
         intel:        "b1b7304fd71142768c5206057881784f017e40cb1ca2b2512224d3df601ae76b",
         x86_64_linux: "b1b7304fd71142768c5206057881784f017e40cb1ca2b2512224d3df601ae76b",
         arm64_linux:  "23d208cf628d67b26b0426ecb720a659caf867c6116d2f192462006d0406d79b"

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
