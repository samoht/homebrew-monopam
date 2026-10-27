class Matter < Formula
  desc "Matter smart home device discovery and control"
  homepage "https://tangled.org/gazagnaire.org/matter"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "b425d98700649f184f63bc7e5a4d1de5acc77546"
  version "20261027-b425d98700649f184f63bc7e5a4d1de5acc77546-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/matter"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d55972359c1f58b4f823c1d520306d6f2ebf488fcd8558e98d0280ddb8a10f4b"
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
