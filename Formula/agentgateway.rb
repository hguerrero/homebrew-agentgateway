class Agentgateway < Formula
  desc "Open source, cloud-native proxy for AI agents, LLMs and MCP/A2A traffic"
  homepage "https://agentgateway.dev"
  # Default (macOS) source. Upstream only publishes an Apple silicon binary, so
  # Intel is excluded below; the Linux blocks override this URL.
  url "https://github.com/agentgateway/agentgateway/releases/download/v1.7.0/agentgateway-darwin-arm64"
  sha256 "34bfc961d0e459d0f89103100e61730d4b5d8e2151c851d33cd034a126eb2bfe"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_intel do
      url "https://github.com/agentgateway/agentgateway/releases/download/v1.7.0/agentgateway-linux-amd64"
      sha256 "1b2fc01a2de29ca113bbb6258b5cae7b1eb3c724071c09d687a449132f2f42f8"
    end
    on_arm do
      url "https://github.com/agentgateway/agentgateway/releases/download/v1.7.0/agentgateway-linux-arm64"
      sha256 "85724a15dc9f5179fb6e2fd85b0ba2d4fea56dd289abb8bf8fefadc3bea8b89e"
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
