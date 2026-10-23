cask "limelight-hardware-manager" do
  version "2.0.13"
  sha256 arm:          "949d3d66e5d5863d246c0fe70ce354c61e4389ce5a392cac7affd7d2013fc280",
         intel:        "4bbe4fe46369ee870666c5ae8acc798f06a03b3cf30bcfbbe1048595b7381b11",
         arm64_linux:  "0b9a03a42ae64f8c0f94ae25822b65538001e3a932c147a9d61c721c355762bd",
         x86_64_linux: "b96035f1e3326f0ddd7bffa608a83e0c6cbe940f0d6c673c78946b11e9b87ee9"

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
