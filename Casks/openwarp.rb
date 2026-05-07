cask "openwarp" do
  version "2026.05.06.preview"
  sha256 "b75f0c20d3596782b592e551b31e388142efdd429cbba9a16f0bd06daa97d239"

  url "https://github.com/zerx-lab/warp/releases/download/v#{version}/OpenWarp-arm64.dmg"
  name "OpenWarp"
  desc "Open source build of Warp Terminal"
  homepage "https://github.com/zerx-lab/warp"

  livecheck do
    url :url
    strategy :github_latest do |json|
      json["tag_name"]&.delete_prefix("v")
    end
  end

  depends_on arch: :arm64
  depends_on macos: ">= :big_sur"

  app "OpenWarp.app"

  zap trash: [
    "~/.warp",
    "~/Library/Application Support/dev.openwarp.OpenWarp",
    "~/Library/Logs/warp.log*",
    "~/Library/Preferences/dev.openwarp.OpenWarp.plist",
    "~/Library/Saved Application State/dev.openwarp.OpenWarp.savedState",
  ]
end
