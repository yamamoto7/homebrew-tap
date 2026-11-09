class Mobicat < Formula
  desc "Android and iOS app logs in one terminal UI"
  homepage "https://github.com/yamamoto7/mobicat"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.1.0/mobicat-aarch64-apple-darwin.tar.xz"
      sha256 "88b859d8b3575120ec62c32e90073c62edbb21d42a339581776c465591987fbb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.1.0/mobicat-x86_64-apple-darwin.tar.xz"
      sha256 "3305652b030ef8c6de4943a2e1a55392b39d9d3d605ab4ee58a38f063fbeb24d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.1.0/mobicat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a48f7f873918d78e52cb1f5bec53623613ce64e1d4651ea7818d9ba215943856"
    end
    if Hardware::CPU.intel?
      url "https://github.com/yamamoto7/mobicat/releases/download/v0.1.0/mobicat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7cc492ddc5f183cf90646d7b33c216899e073486067c57246821c848a6d8349f"
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
