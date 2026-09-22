class Matter < Formula
  desc "Matter smart home device discovery and control"
  homepage "https://tangled.org/gazagnaire.org/matter"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "bf6f0d85f9a9e95846a70f64248b349745032fe7"
  version "20260922-bf6f0d85f9a9e95846a70f64248b349745032fe7"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/matter"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d3994986a585161ad8cbc1499210e08907bd3efe576bd1d64b9879f260f72785"
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
