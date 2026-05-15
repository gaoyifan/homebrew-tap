cask "openwarp" do
  version "0.2026.05.14.1649"
  sha256 "7eb9ac50a316e84bcbc5eaeb023babcb1af9d92edc5390e759e7f4008ef78079"

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
