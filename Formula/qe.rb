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
      sha256 "ac03f3b1526a34a8a1f9a3a8262b79ea637e92a1bce105e141070a4ab4c4c324"
    end
    on_intel do
      url "https://github.com/kroq86/ide/releases/download/v#{version}/qe-v#{version}-darwin-x86_64.tar.gz"
      sha256 "7aa9b5a6bd84c8d487e08fc4ac9d7751145c1fde92c7b4df6ff6b0ccd5614b74"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/kroq86/ide/releases/download/v#{version}/qe-v#{version}-linux-x86_64.tar.gz"
      sha256 "ed5ed96886da373eeb59c1385d3f9dba4dae1c1daa996cd6c382fc006bbd0b07"
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
