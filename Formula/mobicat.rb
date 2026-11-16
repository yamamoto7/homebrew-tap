class Mobicat < Formula
  desc "One log viewer for Android and iOS: your app's logs only, crashes with stack traces, the same keys and filters on both"
  homepage "https://github.com/yamamoto7/mobicat"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.2.0/mobicat-aarch64-apple-darwin.tar.xz"
      sha256 "b0958424c896082338f3a974e77d30a3990c552cf453db280683989d3df0231e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.2.0/mobicat-x86_64-apple-darwin.tar.xz"
      sha256 "40989cf2c25ff9e3d950313a2a188d0725b87604003fc943fa786fa736f1ff91"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.2.0/mobicat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e74047ece96fd84099200f914bbf92a8f03b68eea34e294fd67e03e7bcbef661"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.2.0/mobicat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "485d9c87c9078dae0072d675008329e25960569169589ff3ec30f19114170b31"
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
