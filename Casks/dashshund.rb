cask "dashshund" do
  arch arm: "aarch64", intel: "x64"

  version "2026.4.1"
  sha256 arm:   "84c7e2ffe8ca5e5bdd8fb634fbb2f259ebe95a88f9193de199b0614bbebaa708",
         intel: "7f56d5488d25a7ae35dedf2ed7ed0236b989021729a8c948c625e3451beb2803"

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
