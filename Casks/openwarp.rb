cask "openwarp" do
  version "0.2026.05.13.1008"
  sha256 "ae8d5d6cab5cdec0bb65082778f0a96ddbfc9cb2695e0d28e4c776fe237ac8df"

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
