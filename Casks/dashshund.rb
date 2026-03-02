cask "dashshund" do
  version "2026.0.4"
  sha256 "540a33bcf373fb4aed408dbad8dc687525af9fc74ecb5dbb080106606ea95fbc"

  url "https://github.com/jonahsnider/dashshund/releases/download/v#{version}/Dashshund-#{version}-arm64.dmg",
      verified: "github.com/jonahsnider/dashshund/"
  name "Dashshund"
  desc "FRC dashboard for viewing camera streams"
  homepage "https://github.com/jonahsnider/dashshund"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64

  app "Dashshund.app"
end
