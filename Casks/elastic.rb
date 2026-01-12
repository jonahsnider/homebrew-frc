cask "elastic" do
  version "2026.0.0"
  sha256 "03f4531d58ea08256065612f4940203d792a7a0fd5a533573a9e30caae43973d"

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
