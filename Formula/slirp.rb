class Slirp < Formula
  desc "User-mode network gateway -- no VM, no privilege"
  homepage "https://tangled.org/gazagnaire.org/slirp"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "f8d731a16c87a1ef20ba1886e3a9066a2a28d24a"
  version "20261016-f8d731a16c87a1ef20ba1886e3a9066a2a28d24a-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/slirp"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d85ea3f0e5d6e440bfa44660b2d81cd6b0c827b4fbe633e49e81aefe1079aa2e"
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
