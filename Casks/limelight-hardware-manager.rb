cask "limelight-hardware-manager" do
  version "2.0.11"
  sha256 arm:          "0044e230b2c4a6fb3baa16583a2dc9e8313af23305006e3f1c807825610ed489",
         intel:        "43c3edbcf428fb2d4c0d821ebfda7370e8396fc39d643771c149f8965914bb37",
         arm64_linux:  "eb27b3387a7d8aecddd3efc07c8507d778b90beae6e6157cd324c76c5109cdb5",
         x86_64_linux: "14e277cf380fd577f949d4d352cd3983c9469dc967baa7e62cf350ffdb4fde23"

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
