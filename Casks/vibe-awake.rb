cask "vibe-awake" do
  version "2.0.1"
  sha256 "0125557d8a80e4c60573a4bd9823946d33b1f52d5e3ad32f582227fbd5ee0bc6"

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
  uninstall launchctl:  "com.ychof.vibeawake.helper",
            quit:       "com.ychof.vibeawake",
            login_item: "Vibe Awake",
            script:     {
              executable: "/usr/bin/pmset",
              args:       ["-a", "disablesleep", "0"],
              sudo:       true,
            },
            delete:     [
              "/Library/Application Support/VibeAwake",
              "/Library/LaunchDaemons/com.ychof.vibeawake.helper.plist",
            ]

  zap trash: "~/Library/Preferences/com.ychof.vibeawake.plist"
end
