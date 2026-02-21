# homebrew-monopam

Homebrew tap for OCaml tools.

## Installation

```bash
brew tap samoht/monopam
```

## Available Formulas

| Formula | Description |
|---------|-------------|
| `merlint` | Opinionated OCaml linter powered by Merlin |
| `prune` | Dead code remover for OCaml .mli files |
| `irmin` | Content-addressable store with Git support |
| `crow` | Crowbar campaign orchestrator for AFL fuzzing |
| `agent` | Claude Code container orchestrator |
| `mdns-query` | mDNS service discovery query tool |
| `uniboot` | Bootable disk image builder |
| `git-mono` | Pure OCaml git subtree split |
| `precommit` | Pre-commit hook manager for OCaml projects |
| `bottler` | Homebrew bottle builder and tap manager |
| `monopam` | OCaml monorepo manager with git subtrees |
| `slack` | Slack API command-line client |

## Usage

```bash
# Install pre-built binaries
brew install merlint prune irmin crow agent mdns-query uniboot git-mono precommit bottler monopam slack

# Or build from source
brew install --HEAD merlint
```

## License

ISC
