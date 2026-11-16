class Mobicat < Formula
  desc "One log viewer for Android and iOS: your app's logs only, crashes with stack traces, the same keys and filters on both"
  homepage "https://github.com/yamamoto7/mobicat"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.4.0/mobicat-aarch64-apple-darwin.tar.xz"
      sha256 "85b0dec224802cf693a5946a984a70ba3f1f13d7eaf2a84d0ad768086bac1e0b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.4.0/mobicat-x86_64-apple-darwin.tar.xz"
      sha256 "4aa00d7c65485a7e34516ba1a709dff6c117bab01e899a77c0d1cfe84c53a527"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.4.0/mobicat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b0f04e3c221035794e189d8d798a366a8453d8eff46df719e78dd0f4f9a1328f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.4.0/mobicat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "26784b9843e96aaf61783b3bb264b6189f6df5e11852580fe4040888b0cbc886"
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
