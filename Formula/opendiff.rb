class Opendiff < Formula
  desc "Standalone terminal diff viewer for local git changes"
  homepage "https://github.com/slowestmonkey/opendiff"
  url "https://github.com/slowestmonkey/opendiff/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "c901823d1571a2aa9dc2bb046be4cc03db1da6dbc270698aec98a9d788403737"
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
