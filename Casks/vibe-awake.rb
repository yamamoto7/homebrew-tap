cask "vibe-awake" do
  version "1.0.0"
  sha256 "4216cd085421641c768b80f4d345b7f60d8ce8b08be599be6629fcfd0787a8d1"

  url "https://github.com/yamamoto7/vibe-awake/releases/download/v#{version}/VibeAwake-#{version}.dmg"
  name "Vibe Awake"
  desc "Blocks sleep while an AI coding session is working"
  homepage "https://github.com/yamamoto7/vibe-awake"

  depends_on macos: :ventura

  app "Vibe Awake.app"

  # The privileged helper lives outside the app bundle, so removing the app alone would
  # leave a root LaunchDaemon behind. Homebrew asks for a password to delete these.
  uninstall launchctl: "com.ychof.vibeawake.helper",
            delete:    [
              "/Library/Application Support/VibeAwake",
              "/Library/LaunchDaemons/com.ychof.vibeawake.helper.plist",
            ]

  zap trash: "~/Library/Preferences/com.ychof.vibeawake.plist"
end
