class Prune < Formula
  desc "Dead code remover for OCaml .mli files"
  homepage "https://tangled.org/gazagnaire.org/prune"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "fcfa6a29460bd922549bc168644cb0834239302b"
  version "20260902-fcfa6a29460bd922549bc168644cb0834239302b-dirty"
  conflicts_with "graphviz", because: "both install a `prune` binary"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/prune"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a71992712056913bee1c180632ea79a968cec2e26f1421aaf716938852fb3aa6"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "prune/bin/main.exe"
    bin.install "_build/default/prune/bin/main.exe" => "prune"
  end

  test do
    system bin/"prune", "--help"
  end
end
