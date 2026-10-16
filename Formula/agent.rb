class Agent < Formula
  desc "Claude Code container orchestrator"
  homepage "https://tangled.org/gazagnaire.org/agent"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "f8d731a16c87a1ef20ba1886e3a9066a2a28d24a"
  version "20261016-f8d731a16c87a1ef20ba1886e3a9066a2a28d24a-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/agent"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "731bb284947897ad1404eee032645062de662e4b4d2e8015d6c6f5f8031b9c38"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build
  depends_on "docker" => :recommended

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-agent/bin/main.exe"
    bin.install "_build/default/ocaml-agent/bin/main.exe" => "agent"
  end

  test do
    system bin/"agent", "--help"
  end
end
