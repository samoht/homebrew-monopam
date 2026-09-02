class Dupfind < Formula
  desc "Find cross-package duplicate code"
  homepage "https://tangled.org/gazagnaire.org/dupfind"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "fcfa6a29460bd922549bc168644cb0834239302b"
  version "20260902-fcfa6a29460bd922549bc168644cb0834239302b-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/dupfind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b02ad567b744936c6f6a8624726242ca741465065b9a11ee32565f9b5af2bd66"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "dupfind/bin/main.exe"
    bin.install "_build/default/dupfind/bin/main.exe" => "dupfind"
  end

  test do
    system bin/"dupfind", "--help"
  end
end
