cask "dashshund" do
  arch arm: "aarch64", intel: "x64"

  version "2026.5.0"
  sha256 arm:   "a983571173d3e05621521ad8973cffc703885fd42efa520c8ee5661b6dd16550",
         intel: "668278f120125f93b2a969f1bcafdd77fb49a26a1faae0e405704a4649a50280"

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
