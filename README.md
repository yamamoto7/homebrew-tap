# homebrew-tap

[yamamoto7](https://github.com/yamamoto7) の Homebrew タップ。

## インストール

```bash
brew install --cask yamamoto7/tap/vibe-awake
```

タップを先に追加しておくこともできます。

```bash
brew tap yamamoto7/tap
brew install --cask vibe-awake
```

## 収録しているもの

| | 説明 |
|---|---|
| [vibe-awake](https://github.com/yamamoto7/vibe-awake) | AI コーディングセッションが動いている間だけ Mac を寝かせないメニューバーアプリ |

## メンテナ向け

新しいバージョンを出したら、対象の cask の `version` と `sha256` を更新します。

```bash
# チェックサムは配布した DMG から取得する
shasum -a 256 VibeAwake-<version>.dmg

# 変更後に検証
brew audit --cask --online Casks/vibe-awake.rb
brew style Casks/vibe-awake.rb
```
