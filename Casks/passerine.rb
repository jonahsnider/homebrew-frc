cask "passerine" do
  version "0.0.1"
  sha256 "801855cd2bcfaecb3bb3e6bff3a09d193a3a15191637de915f36b0d86e210d6f"

  url "https://redist.ctr-electronics.com/tools/passerine/#{version}/passerine-#{version}-macosuniversal"
  name "Passerine"
  desc "Convert MIDI files into CTR Electronics CHRP (.chrp) files"
  homepage "https://docs.ctr-electronics.com/cli-tools"

  livecheck do
    url "https://redist.ctr-electronics.com/index.json"
    strategy :json do |json|
      json["Tools"]&.find { |t| t["Name"] == "passerine" }&.dig("Items")&.filter_map do |item|
        next unless item["Urls"]&.key?("macosuniversal")

        version = item["Version"]
        next if version&.match?(/alpha|beta/i)

        version
      end
    end
  end

  binary "passerine-#{version}-macosuniversal", target: "passerine"
end
