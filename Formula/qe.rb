# Homebrew formula for qe.
#
# To publish a tap:
#   1. Create a GitHub repo named  kroq86/homebrew-qe
#   2. Place this file at  Formula/qe.rb  inside that repo
#   3. Update the sha256 values after each release (see the sha256 note below)
#
# Users install with:
#   brew tap kroq86/qe
#   brew install qe
#
# To get sha256 values after publishing a GitHub Release:
#   curl -sL <tarball-url> | sha256sum

class Qe < Formula
  desc "Terminal editor: Vim keybindings, Git, LSP, AI (optional)"
  homepage "https://github.com/kroq86/ide"
  license "MIT"
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://github.com/kroq86/ide/releases/download/v#{version}/qe-v#{version}-darwin-arm64.tar.gz"
      sha256 "d4e545aef4a7a203d9e92339de77c54e5070781cdfe0deaa1b9e79b1b52670fb"
    end
    on_intel do
      url "https://github.com/kroq86/ide/releases/download/v#{version}/qe-v#{version}-darwin-x86_64.tar.gz"
      sha256 "905cd86f5d4a914a30a4d2e0afeb3eb099e6451b7d3d87a4ceb141cc252b8875"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/kroq86/ide/releases/download/v#{version}/qe-v#{version}-linux-x86_64.tar.gz"
      sha256 "259cac3028dd884cac6cf6d856ca9aac88c328b32679c136800466d74d1bdb1c"
    end
  end

  depends_on "node"

  def install
    libexec.install Dir["libexec/*"]
    chmod 0755, libexec/"editor-core"

    (bin/"qe").write <<~SH
      #!/bin/sh
      exec node "#{libexec}/main.js" "$@"
    SH
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qe --version 2>&1", 1)
  end
end
