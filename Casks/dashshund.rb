cask "dashshund" do
  arch arm: "aarch64", intel: "x64"

  version "2026.4.0"
  sha256 arm:   "066c20c9ddda2acae4fa061683ec0af6b7f77232a1e6e84f418c291b1709494e",
         intel: "14fdee9f98c243ee6b7990d3558f643e5ffe011d7662d87d6fb274238a6da195"

  url "https://github.com/jonahsnider/dashshund/releases/download/v#{version}/Dashshund_#{version}_#{arch}.dmg"
  name "Dashshund"
  desc "FRC dashboard for viewing camera streams"
  homepage "https://github.com/jonahsnider/dashshund"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "Dashshund.app"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.team581.dashshund.sfl*",
    "~/Library/Application Support/dashshund",
    "~/Library/Preferences/com.team581.dashshund.plist",
  ]
end
