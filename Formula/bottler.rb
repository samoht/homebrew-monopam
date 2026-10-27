class Bottler < Formula
  desc "Homebrew bottle builder and tap manager"
  homepage "https://tangled.org/gazagnaire.org/bottler"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "b425d98700649f184f63bc7e5a4d1de5acc77546"
  version "20261027-b425d98700649f184f63bc7e5a4d1de5acc77546-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/bottler"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "79f6cf1fa853825a2a1f88c4ebde58d1076ab6457c3c8360641f8c9daf0cbcf1"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "bottler/bin/main.exe"
    bin.install "_build/default/bottler/bin/main.exe" => "bottler"
  end

  test do
    system bin/"bottler", "--help"
  end
end
