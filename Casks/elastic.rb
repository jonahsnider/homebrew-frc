cask "elastic" do
  version "2026.1.2"
  sha256 "5f733a6299fe7ddfb127b61beec3ca62e2cfc61205976400bc0c686a2c948bc0"

  url "https://github.com/Gold872/elastic_dashboard/releases/download/v#{version}/Elastic-macOS.zip",
      verified: "github.com/Gold872/elastic_dashboard/"
  name "Elastic Dashboard"
  desc "Simple and modern dashboard for FRC"
  homepage "https://frc-elastic.gitbook.io/docs"

  depends_on macos: ">= :catalina"

  app "elastic_dashboard.app", target: "Elastic.app"

  zap trash: [
    "~/Library/Application Scripts/com.gold872.elasticDashboard",
    "~/Library/Containers/com.gold872.elasticDashboard",
  ]
end
