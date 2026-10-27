class Prune < Formula
  desc "Dead code remover for OCaml .mli files"
  homepage "https://tangled.org/gazagnaire.org/prune"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "b425d98700649f184f63bc7e5a4d1de5acc77546"
  version "20261027-b425d98700649f184f63bc7e5a4d1de5acc77546-dirty"
  conflicts_with "graphviz", because: "both install a `prune` binary"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/prune"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "c81b7df05f443329df67d27c8b3af3b08502948ab4d9cbe4fd34b0b852d5f669"
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
