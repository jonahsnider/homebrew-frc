cask "dashshund" do
  version "2026.1.1"
  sha256 "4009a3fd5c790fe1e0f39cc7f7bd1fbe6b7f79d5a53be27a0581c15c4229eab4"

  url "https://github.com/jonahsnider/dashshund/releases/download/v#{version}/Dashshund-#{version}-arm64.dmg"
  name "Dashshund"
  desc "FRC dashboard for viewing camera streams"
  homepage "https://github.com/jonahsnider/dashshund"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "Dashshund.app"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.team581.dashshund.sfl*",
    "~/Library/Application Support/dashshund",
    "~/Library/Preferences/com.team581.dashshund.plist",
  ]
end
