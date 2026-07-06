cask "elastic" do
  version "2026.1.2"

  on_macos do
    sha256 "5f733a6299fe7ddfb127b61beec3ca62e2cfc61205976400bc0c686a2c948bc0"

    url "https://github.com/Gold872/elastic_dashboard/releases/download/v#{version}/Elastic-macOS.zip",
        verified: "github.com/Gold872/elastic_dashboard/"
  end

  on_linux do
    sha256 "6103b70fe1788cee4929916f8f8b9987efe3cf469aaf122f47cecfb83f6267c1"

    url "https://github.com/Gold872/elastic_dashboard/releases/download/v#{version}/Elastic-Linux.zip",
        verified: "github.com/Gold872/elastic_dashboard/"
  end

  name "Elastic Dashboard"
  desc "Simple and modern dashboard for FRC"
  homepage "https://frc-elastic.gitbook.io/docs"

  on_macos do
    depends_on macos: :catalina

    app "elastic_dashboard.app", target: "Elastic.app"

    zap trash: [
      "~/Library/Application Scripts/com.gold872.elasticDashboard",
      "~/Library/Containers/com.gold872.elasticDashboard",
    ]
  end

  on_linux do
    depends_on arch: :x86_64

    binary "elastic_dashboard", target: "elastic"
  end
end
