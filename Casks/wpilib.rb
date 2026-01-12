cask "wpilib" do
  arch arm: "macOSArm", intel: "macOS"
  arch_suffix = on_arch_conditional arm: "Arm64", intel: "Intel"

  version "2026.1.1"
  sha256 arm:   "4839ba17ae1282c988227be56d50d070a2451746c0e41b6bc8aef8c222d94542",
         intel: "2a7914340395538f814cca8bee8d2b592a51b68e6cce004b93ee2d802bb73ca2"

  url "https://packages.wpilib.workers.dev/installer/v#{version}/#{arch}/WPILib_macOS-#{arch_suffix}-#{version}.dmg",
      verified: "wpilib.workers.dev/"
  name "WPILib"
  desc "Standard software library provided for FRC teams to write robot code"
  homepage "https://wpilib.org/"

  livecheck do
    url "https://github.com/wpilibsuite/allwpilib"
  end

  installer manual: "WPILibInstaller.app"

  uninstall delete: "~/wpilib/#{version.major}"
end
