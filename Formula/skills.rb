class Skills < Formula
  desc "Claude Code skills manager"
  homepage "https://tangled.org/gazagnaire.org/skills"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "fcfa6a29460bd922549bc168644cb0834239302b"
  version "20260902-fcfa6a29460bd922549bc168644cb0834239302b-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/skills"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "719b0eec7630d316525fdf4bf6e08804e227280ed92a607645a1974c5b580fa2"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-claude-skills/bin/main.exe"
    bin.install "_build/default/ocaml-claude-skills/bin/main.exe" => "skills"
  end

  test do
    system bin/"skills", "--help"
  end
end
