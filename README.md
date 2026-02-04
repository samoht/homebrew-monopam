# homebrew-monopam

Homebrew tap.

## Installation

```bash
brew tap gazagnaire.org/monopam https://tangled.org/gazagnaire.org/homebrew-monopam.git
```

## Available Formulas

| Formula | Description |
|---------|-------------|
| `prune` | Find and remove unused exports in OCaml interface files |
| `irmin` | Content-addressable store with Git and ATProto MST support |
| `crow` | Crowbar campaign orchestrator for AFL fuzzing |
| `agent` | Claude Code container orchestrator |
| `mdns-query` | mDNS service discovery query tool |
| `uniboot` | Bootable disk image builder with GPT partition tables |

## Usage

```bash
# Install pre-built binary (fast)
brew install prune
brew install irmin crow agent mdns-query uniboot

# Or build from source
brew install --HEAD prune
```

## License

ISC
