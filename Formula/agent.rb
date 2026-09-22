class Agent < Formula
  desc "Claude Code container orchestrator"
  homepage "https://tangled.org/gazagnaire.org/agent"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "bf6f0d85f9a9e95846a70f64248b349745032fe7"
  version "20260922-bf6f0d85f9a9e95846a70f64248b349745032fe7"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/agent"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "10383c63771466f8277b659167e217484b9b87dcc8f8b9ecc20931d141c13060"
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
