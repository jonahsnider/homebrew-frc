cask "choreo" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macOS", linux: "Linux"

  version "2026.0.3"

  on_macos do
    sha256 arm:   "e3855d9ec09c3a335ede5d5e6bcdfcaa94165a195ab33c956a2c2043a15d9bcb",
           intel: "ab7b3cec24cd7599cc389dca7fbf0b38da068b0ee7dd734bdbb7e47bbeaa4de8"

    url "https://github.com/SleipnirGroup/Choreo/releases/download/v#{version}/Choreo-v#{version}-#{os}-#{arch}.dmg",
        verified: "github.com/SleipnirGroup/Choreo/"
  end

  on_linux do
    sha256 arm64_linux:  "28315c728117725dea4bb16212eda47946aafe98f04f9b5e073b295a12a4ac91",
           x86_64_linux: "e70d421d067ed3faeaeae4ad537ab7e82eabce98354e694820b612190ab1de4b"

    url "https://github.com/SleipnirGroup/Choreo/releases/download/v#{version}/Choreo-v#{version}-#{os}-#{arch}-standalone.zip",
        verified: "github.com/SleipnirGroup/Choreo/"
  end

  name "Choreo"
  desc "Time-optimal drivetrain trajectory planner for the FIRST Robotics Competition"
  homepage "https://choreo.autos/"

  livecheck do
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    depends_on macos: :sonoma

    app "Choreo.app"

    zap trash: "~/Library/Application Support/choreo"
  end

  on_linux do
    binary "choreo"
  end
end
