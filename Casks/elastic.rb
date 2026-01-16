cask "elastic" do
  version "2026.1.1"
  sha256 "4161205104a3e4f72954f47da1e2e0623b8274070357cdc1a11b2101bc182f39"

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
