cask "wpilib" do
  arch arm: "macOSArm", intel: "macOS"
  arch_suffix = on_arch_conditional arm: "Arm64", intel: "Intel"

  version "2026.2.1"
  sha256 arm:   "98c13566292993d3f32c0e0765430617f56c18d85d608115821442fefffe6dcb",
         intel: "3f725ff13c08ad61dd51f695e25b019e0e13474639f2db0f27f18f0d366022bb"

  url "https://packages.wpilib.workers.dev/installer/v#{version}/#{arch}/WPILib_macOS-#{arch_suffix}-#{version}.dmg",
      verified: "wpilib.workers.dev/"
  name "WPILib"
  desc "Standard software library provided for FRC teams to write robot code"
  homepage "https://wpilib.org/"

  livecheck do
    url "https://github.com/wpilibsuite/allwpilib"
    strategy :github_latest
  end

  installer manual: "WPILibInstaller.app"

  uninstall delete: "~/wpilib/#{version.major}"
end
