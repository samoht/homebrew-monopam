class Prune < Formula
  desc "Dead code remover for OCaml .mli files"
  homepage "https://tangled.org/gazagnaire.org/prune"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "f8d731a16c87a1ef20ba1886e3a9066a2a28d24a"
  version "20261016-f8d731a16c87a1ef20ba1886e3a9066a2a28d24a-dirty"
  conflicts_with "graphviz", because: "both install a `prune` binary"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/prune"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "c82f7ffca26418f830366ba8fd51b75225bf08d4cb8c38cecf9ec07317d76ed2"
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
