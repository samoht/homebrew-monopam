class Agent < Formula
  desc "Claude Code container orchestrator"
  homepage "https://tangled.org/gazagnaire.org/agent"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "fcfa6a29460bd922549bc168644cb0834239302b"
  version "20260902-fcfa6a29460bd922549bc168644cb0834239302b-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/agent"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "75119f6ac6bd79892e85a78311562e1ffb04edd53e2d4aeeffe600f0e6964397"
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
