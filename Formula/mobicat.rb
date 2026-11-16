class Mobicat < Formula
  desc "One log viewer for Android and iOS: your app's logs only, crashes with stack traces, the same keys and filters on both"
  homepage "https://github.com/yamamoto7/mobicat"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.3.0/mobicat-aarch64-apple-darwin.tar.xz"
      sha256 "e17617bcb90042425ba586b9c833589868639eca96da2fa5b17462e88e46ae9d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.3.0/mobicat-x86_64-apple-darwin.tar.xz"
      sha256 "b157d5324cb21ed509f2effcc90d11907f1e16cf9e13bee4c71f983f6f7bdf4b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.3.0/mobicat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7d46c522d84114c6fa161a43d5472d99a1de90f4a92858c30b01545f3bab8b83"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.3.0/mobicat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e679a966ed91778230c757640bf2d84cf92cb8e76e44057fc04de2872d32a5db"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "mobicat"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mobicat"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mobicat"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mobicat"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
