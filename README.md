# homebrew-agentgateway

Homebrew tap for [agentgateway](https://agentgateway.dev).

```sh
brew install agentgateway/agentgateway/agentgateway
# or
brew tap agentgateway/agentgateway
brew install agentgateway
```

Homebrew requires explicit trust for third-party taps. If `brew install` asks
for it, trust just this formula:

```sh
brew trust --formula agentgateway/agentgateway/agentgateway
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
PR. The PR runs `brew test-bot` (`.github/workflows/tests.yml`), which audits
the formula and builds a bottle. For those checks to run on a bot-created PR,
add a `BUMP_TOKEN` repository secret (a PAT); PRs opened with the default
`GITHUB_TOKEN` do not trigger workflows.

To bump by hand:

```sh
scripts/bump.sh v1.7.0
```

To test a change locally before pushing:

```sh
brew install --build-from-source agentgateway/agentgateway/agentgateway
brew test agentgateway
brew audit --strict agentgateway/agentgateway/agentgateway
```

## Publishing

Review each bump PR and wait for its checks to pass. Then publish its bottles
with `brew pr-pull` (preferably with the reviewed commit SHA):

```sh
brew pr-pull --tap=agentgateway/agentgateway --head-sha=<sha> <PR number>
```

or run the **brew pr-pull** workflow from the Actions tab with the PR number
and, optionally, the expected head SHA.

Bottles are only built for macOS (Apple silicon) and Linux x86_64. Other
platforms install the upstream binary directly, as before.
