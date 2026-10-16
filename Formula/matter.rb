class Matter < Formula
  desc "Matter smart home device discovery and control"
  homepage "https://tangled.org/gazagnaire.org/matter"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "f8d731a16c87a1ef20ba1886e3a9066a2a28d24a"
  version "20261016-f8d731a16c87a1ef20ba1886e3a9066a2a28d24a-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/matter"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "003f85311473bc19d7d7e77469b9746d400c9d0c4868af4e47b633cd7bd88ed0"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-matter/bin/matter_cli.exe"
    bin.install "_build/default/ocaml-matter/bin/matter_cli.exe" => "matter"
  end

  test do
    system bin/"matter", "--help"
  end
end
