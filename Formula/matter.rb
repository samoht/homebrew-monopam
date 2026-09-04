class Matter < Formula
  desc "Matter smart home device discovery and control"
  homepage "https://tangled.org/gazagnaire.org/matter"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c7cfbb598ec5b709439158712db26318961fbe2"
  version "20260904-9c7cfbb598ec5b709439158712db26318961fbe2"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/matter"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "ef20cff6f5d037ac2ad20e44459e0f4146656588b082ef64816f246c2b0da89c"
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
