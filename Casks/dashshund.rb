cask "dashshund" do
  arch arm: "aarch64", intel: "x64"

  version "2026.8.0"
  sha256 arm:   "a8d9e72400fa25d805b8395a5d89e30c03f89a1292b6ce5318286b5b1c9cee3c",
         intel: "869c81afeaee8e14f5becd9f576ec7b6503909f7f4f5466effc4e2d1825cf411"

  url "https://github.com/jonahsnider/dashshund/releases/download/v#{version}/Dashshund_#{version}_#{arch}.dmg"
  name "Dashshund"
  desc "FRC dashboard for viewing camera streams"
  homepage "https://github.com/jonahsnider/dashshund"

  depends_on macos: :monterey

  app "Dashshund.app"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.team581.dashshund.sfl*",
    "~/Library/Application Support/dashshund",
    "~/Library/Preferences/com.team581.dashshund.plist",
  ]
end
