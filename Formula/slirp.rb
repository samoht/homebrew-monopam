class Slirp < Formula
  desc "User-mode network gateway -- no VM, no privilege"
  homepage "https://tangled.org/gazagnaire.org/slirp"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "b425d98700649f184f63bc7e5a4d1de5acc77546"
  version "20261027-b425d98700649f184f63bc7e5a4d1de5acc77546-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/slirp"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "e1186b6b5fd6f489aefa3483d7a25d251d3a45b2d9d918551babb0c3b60aca2b"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-slirp/bin/main.exe"
    bin.install "_build/default/ocaml-slirp/bin/main.exe" => "slirp"
  end

  test do
    system bin/"slirp", "--help"
  end
end
