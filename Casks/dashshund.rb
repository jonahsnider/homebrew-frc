cask "dashshund" do
  arch arm: "aarch64", intel: "x64"

  version "2026.7.1"
  sha256 arm:   "3d1d769e92340e70e7924212f864945a4dce76182436533f9f2060c34f0a40bf",
         intel: "9946af99332049b81545f431f6a4729d4aacbc1697b0d351a6417ce9deb25669"

  url "https://github.com/jonahsnider/dashshund/releases/download/v#{version}/Dashshund_#{version}_#{arch}.dmg"
  name "Dashshund"
  desc "FRC dashboard for viewing camera streams"
  homepage "https://github.com/jonahsnider/dashshund"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Dashshund.app"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.team581.dashshund.sfl*",
    "~/Library/Application Support/dashshund",
    "~/Library/Preferences/com.team581.dashshund.plist",
  ]
end
