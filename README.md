# homebrew-agentgateway

Homebrew tap for [agentgateway](https://agentgateway.dev).

```sh
brew install agentgateway/agentgateway/agentgateway
# or
brew tap agentgateway/agentgateway
brew install agentgateway
```

Verify:

```sh
agentgateway --version
```

## Supported platforms

The formula installs the prebuilt binaries attached to each
[GitHub release](https://github.com/agentgateway/agentgateway/releases):

| Platform             | Release asset                |
| -------------------- | ---------------------------- |
| macOS (Apple silicon)| `agentgateway-darwin-arm64`  |
| Linux x86_64         | `agentgateway-linux-amd64`   |
| Linux arm64          | `agentgateway-linux-arm64`   |

Intel macOS is not supported because upstream does not publish a binary for it.

## Why a formula and not a cask

The release assets are bare CLI binaries, not `.app`, `.dmg` or `.pkg` bundles,
so a formula is the right fit and also covers Linux (Linuxbrew).

## Updating

`.github/workflows/bump.yml` checks hourly for a new stable release and opens a
PR. To bump by hand:

```sh
scripts/bump.sh v1.7.0
```
