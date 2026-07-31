class Prune < Formula
  desc "Dead code remover for OCaml .mli files"
  homepage "https://tangled.org/gazagnaire.org/prune"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c9d0aca8fb9be39251315708f223f03adb861eb"
  version "20260730-9c9d0aca8fb9be39251315708f223f03adb861eb-dirty"
  conflicts_with "graphviz", because: "both install a `prune` binary"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/prune"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "965f8147183a05605a98a725a7b1e810b70f2456a7529b0d68fa600323340aaf"
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
