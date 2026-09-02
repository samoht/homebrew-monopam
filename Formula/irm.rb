class Irm < Formula
  desc "Content-addressable store with Git support"
  homepage "https://tangled.org/gazagnaire.org/irm"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "fcfa6a29460bd922549bc168644cb0834239302b"
  version "20260902-fcfa6a29460bd922549bc168644cb0834239302b-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/irm"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "381b37fa7a0e1140088c59eb6389c9c6355636d9373ca23f0dafb857a0a5630d"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "irmin/bin/main.exe"
    bin.install "_build/default/irmin/bin/main.exe" => "irm"
  end

  test do
    system bin/"irm", "--help"
  end
end
