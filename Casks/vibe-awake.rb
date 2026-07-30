cask "vibe-awake" do
  version "1.0.0"
  sha256 "4216cd085421641c768b80f4d345b7f60d8ce8b08be599be6629fcfd0787a8d1"

  url "https://github.com/yamamoto7/vibe-awake/releases/download/v#{version}/VibeAwake-#{version}.dmg"
  name "Vibe Awake"
  desc "Blocks sleep while an AI coding session is working"
  homepage "https://github.com/yamamoto7/vibe-awake"

  depends_on macos: :ventura

  app "Vibe Awake.app"

  # The app blocks sleep through a privileged helper that sets `pmset disablesleep`, so
  # removing the app alone is not enough. Deleting the helper while that flag is still set
  # strands the machine: nothing is left that can turn it back off, and it stops sleeping
  # on a closed lid for good.
  #
  # Homebrew runs these in a fixed order (launchctl -> quit -> script -> delete), which is
  # exactly what is needed:
  #   launchctl  unload the helper so it cannot re-apply the flag
  #   quit       stop the app, which would otherwise keep requesting sleep be blocked
  #   script     clear the flag, now that nothing is left to set it again
  #   delete     remove the helper's files
  uninstall launchctl: "com.ychof.vibeawake.helper",
            quit:      "com.ychof.vibeawake",
            script:    {
              executable: "/usr/bin/pmset",
              args:       ["-a", "disablesleep", "0"],
              sudo:       true,
            },
            delete:    [
              "/Library/Application Support/VibeAwake",
              "/Library/LaunchDaemons/com.ychof.vibeawake.helper.plist",
            ]

  zap trash: "~/Library/Preferences/com.ychof.vibeawake.plist"
end
