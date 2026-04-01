cask "dashshund" do
  arch arm: "aarch64", intel: "x64"

  version "2026.7.0"
  sha256 arm:   "7fe5b67cb1b4b321dffe8755fe53697d94ae4b2c803c109a6fd054f6a5eda02c",
         intel: "00bbac885780a7394e160de7da58081ab5a06c55d7419c491f6aa85f5bc15d19"

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
