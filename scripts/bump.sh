#!/usr/bin/env bash
# Rewrite Formula/agentgateway.rb for a given agentgateway release.
# Usage: scripts/bump.sh [vX.Y.Z]   (defaults to the latest GitHub release)
set -euo pipefail

REPO="agentgateway/agentgateway"
FORMULA="$(cd "$(dirname "$0")/.." && pwd)/Formula/agentgateway.rb"

tag="${1:-$(gh release view --repo "$REPO" --json tagName -q .tagName)}"
tag="v${tag#v}"
version="${tag#v}"
base="https://github.com/${REPO}/releases/download/${tag}"

sha_for() {
  # The .sha256 asset is "<hash>  outputs/<name>"; keep only the hash.
  curl -fsSL "${base}/agentgateway-$1.sha256" | awk '{print $1}'
}

darwin_arm64="$(sha_for darwin-arm64)"
linux_amd64="$(sha_for linux-amd64)"
linux_arm64="$(sha_for linux-arm64)"

cat > "$FORMULA" <<EOF
class Agentgateway < Formula
  desc "Open source, cloud-native proxy for AI agents, LLMs and MCP/A2A traffic"
  homepage "https://agentgateway.dev"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "${base}/agentgateway-darwin-arm64"
      sha256 "${darwin_arm64}"
    end
  end

  on_linux do
    on_intel do
      url "${base}/agentgateway-linux-amd64"
      sha256 "${linux_amd64}"
    end
    on_arm do
      url "${base}/agentgateway-linux-arm64"
      sha256 "${linux_arm64}"
    end
  end

  def install
    # The release asset is a bare, prebuilt binary named agentgateway-<os>-<arch>.
    binary = Dir["agentgateway-*"].first
    chmod 0755, binary
    bin.install binary => "agentgateway"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentgateway --version")
  end
end
EOF

echo "Formula updated to ${tag}"
