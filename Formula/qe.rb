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
  version "0.1.1"

  on_macos do
    on_arm do
      url "https://github.com/kroq86/ide/releases/download/v#{version}/qe-v#{version}-darwin-arm64.tar.gz"
      sha256 "192e07487b04d59254735aee52323ee1af7ceba4bc42a1fac576ebdce3d587b7"
    end
    on_intel do
      url "https://github.com/kroq86/ide/releases/download/v#{version}/qe-v#{version}-darwin-x86_64.tar.gz"
      sha256 "7e2287c124dc0004ece73a38d0cc57e3a0e36a21f913d4aa30db449fcaae6e22"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/kroq86/ide/releases/download/v#{version}/qe-v#{version}-linux-x86_64.tar.gz"
      sha256 "96f3f02bb8f169842be3fbeb01bbf30fd5845518cfe735d49823ce28a7c97967"
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
