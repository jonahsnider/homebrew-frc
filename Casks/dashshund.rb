cask "dashshund" do
  arch arm: "aarch64", intel: "x64"

  version "2026.5.1"
  sha256 arm:   "6b22e9c75574d9e5d3134e2fb916d3bb36da987f9ca018eab4f5571ae4440d4c",
         intel: "398974ab22adac9625ca111f566bda9e05c59bfc561c46581e2f404c5775e1a1"

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
