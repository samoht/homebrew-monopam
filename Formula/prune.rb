class Prune < Formula
  desc "Dead code remover for OCaml .mli files"
  homepage "https://tangled.org/gazagnaire.org/prune"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c7cfbb598ec5b709439158712db26318961fbe2"
  version "20260904-9c7cfbb598ec5b709439158712db26318961fbe2"
  conflicts_with "graphviz", because: "both install a `prune` binary"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/prune"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "bcdcc7fc5f224ef30e629b001e2749b954b3530798277c3ebea72a2a61c75810"
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
