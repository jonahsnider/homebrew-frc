cask "elastic" do
  version "2026.1.0"
  sha256 "fbc9182ad9b158c402f81829e22c8837bf4f7d47f2ffef120017113f7ab026f6"

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
