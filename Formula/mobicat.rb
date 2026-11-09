class Mobicat < Formula
  desc "One log viewer for Android and iOS: your app's logs only, crashes with stack traces, the same keys and filters on both"
  homepage "https://github.com/yamamoto7/mobicat"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.1.1/mobicat-aarch64-apple-darwin.tar.xz"
      sha256 "d0d188fc3b415d81df94815aa224068227a47b1c55338548a4cbc9262e35e684"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.1.1/mobicat-x86_64-apple-darwin.tar.xz"
      sha256 "e9d717a5f2583e16f3a3ff1f65e87c9d82255889053648f0b13f3b68949c1dab"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.1.1/mobicat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "159022026102bb939847fe6d56c333cf789699a48e42576d236fb898330d3ea0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.1.1/mobicat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d051e6dd8356713938dc60a93506089bc04fb2146f68d27e28ea679bbccb4ecf"
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
