class Opendiff < Formula
  desc "Standalone terminal diff viewer for local git changes"
  homepage "https://github.com/slowestmonkey/opendiff"
  url "https://github.com/slowestmonkey/opendiff/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "19a60b4fd180a6dc66816e11825a24c6a855449ebcf2944d6bf68c7fb6f39aa5"
  license "MIT"
  head "https://github.com/slowestmonkey/opendiff.git", branch: "main"

  depends_on "bun"

  def install
    system "bun", "install", "--frozen-lockfile"
    libexec.install Dir["*"]
    (bin/"opendiff").write <<~SH
      #!/bin/bash
      exec "#{Formula["bun"].opt_bin}/bun" \\
        --preload "#{libexec}/packages/tui/node_modules/@opentui/solid/scripts/preload.js" \\
        "#{libexec}/packages/tui/src/opendiff/index.ts" "$@"
    SH
  end

  test do
    assert_match "opendiff", shell_output("#{bin}/opendiff --help")
  end
end
