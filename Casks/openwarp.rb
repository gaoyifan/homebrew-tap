cask "openwarp" do
  version "2026.05.10.preview"
  sha256 "3c7172e12aff48136b8ca146d7f8b6fcaf9179035ee9fae7a7a38c475aff85df"

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

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/OpenWarp.app"]
  end

  zap trash: [
    "~/.warp",
    "~/Library/Application Support/dev.openwarp.OpenWarp",
    "~/Library/Logs/warp.log*",
    "~/Library/Preferences/dev.openwarp.OpenWarp.plist",
    "~/Library/Saved Application State/dev.openwarp.OpenWarp.savedState",
  ]
end
