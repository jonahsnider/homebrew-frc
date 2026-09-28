cask "limelight-hardware-manager" do
  version "2.0.12"
  sha256 arm:          "d2c53820fd256261a665427000e73552e06506091a97b4c29d2451e135e59bf3",
         intel:        "1e84d76475724059be5d3f3e38e5eff7c0cb00c1ae28a0bde660a6ae68e2abff",
         arm64_linux:  "7a0efdc10ceffda6a8e06c69699181c0190e92437c4aff90db3c6394e96b5c34",
         x86_64_linux: "24d23f144fef3d4e006cd1dfcfeeec3d217c1c05be2bb3329fdf8f5a33e2518e"

  on_macos do
    arch arm: "AppleSilicon", intel: "Intel"

    url "https://downloads.limelightvision.io/software/LimelightHardwareManager-macOS-#{arch}#{version.dots_to_underscores}.dmg"

    app "Limelight Hardware Manager.app"

    zap trash: "~/Library/Preferences/com.limelight.hardwaremanager.plist"
  end
  on_linux do
    arch arm: "aarch64", intel: "x86_64"

    url "https://downloads.limelightvision.io/software/LimelightHardwareManager-#{arch}_#{version.dots_to_underscores}.AppImage.zip"

    app_image "LimelightHardwareManager-#{arch}.AppImage", target: "Limelight Hardware Manager.AppImage"
  end

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
end
