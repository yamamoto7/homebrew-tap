# homebrew-tap

[yamamoto7](https://github.com/yamamoto7) の Homebrew タップ。

## インストール

```bash
brew tap yamamoto7/tap
brew trust yamamoto7/tap
brew install --cask vibe-awake
```

Homebrew 6 ではサードパーティのタップを明示的に信頼しないと cask を読み込めません。
`brew trust` を省くと「Refusing to load cask ... from untrusted tap」でインストールが止まります。

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
