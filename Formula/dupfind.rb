class Dupfind < Formula
  desc "Find cross-package duplicate code"
  homepage "https://tangled.org/gazagnaire.org/dupfind"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "b425d98700649f184f63bc7e5a4d1de5acc77546"
  version "20261027-b425d98700649f184f63bc7e5a4d1de5acc77546-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/dupfind"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "9468ccd8ca953643945c7764e65b4e3ce550c0132b2fe07aa4c92a7b1f8f3653"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "dupfind/bin/main.exe"
    bin.install "_build/default/dupfind/bin/main.exe" => "dupfind"
  end

  test do
    system bin/"dupfind", "--help"
  end
end
