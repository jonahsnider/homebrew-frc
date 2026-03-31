cask "dashshund" do
  arch arm: "aarch64", intel: "x64"

  version "2026.6.0"
  sha256 arm:   "6991eb7a7374ad762cf3f7413ca3cd34a9ab6b52d18cc95e556ee8af28f42f95",
         intel: "c49e244c6868d59e4a1cb63f2654aeaae14b991b53d6cafc7b11db64e555dca2"

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
