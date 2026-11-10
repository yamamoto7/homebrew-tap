class Mobicat < Formula
  desc "One log viewer for Android and iOS: your app's logs only, crashes with stack traces, the same keys and filters on both"
  homepage "https://github.com/yamamoto7/mobicat"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.1.2/mobicat-aarch64-apple-darwin.tar.xz"
      sha256 "8522fe51f8401c0d2c14497e9ce932a41bb0b6ec2058fb6a21f60653c490a615"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.1.2/mobicat-x86_64-apple-darwin.tar.xz"
      sha256 "06c5c5098f3e5ad31114e904df680428ccd2ef1bf581e7f2e82868504d1c1678"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.1.2/mobicat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ad800e3f7bf6e9b69422e497926bd1c8f53e05900b52b1ee09d39782cb8f8c07"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.1.2/mobicat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "69808446fd6ac049ffd3f0ebf1bf0d0cf944482daf752d36534b2161400240aa"
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
