class Precommit < Formula
  desc "Pre-commit hook manager for OCaml projects"
  homepage "https://tangled.org/gazagnaire.org/precommit"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "fcfa6a29460bd922549bc168644cb0834239302b"
  version "20260902-fcfa6a29460bd922549bc168644cb0834239302b-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/precommit"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "81803b3a6be8e8ece38c67b8c210186c6e1c52b4e7c6d8c12c1c573e0b1cdd05"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-precommit/bin/main.exe"
    bin.install "_build/default/ocaml-precommit/bin/main.exe" => "precommit"
  end

  test do
    system bin/"precommit", "--help"
  end
end
