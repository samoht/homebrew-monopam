class Slirp < Formula
  desc "User-mode network gateway -- no VM, no privilege"
  homepage "https://tangled.org/gazagnaire.org/slirp"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "fcfa6a29460bd922549bc168644cb0834239302b"
  version "20260902-fcfa6a29460bd922549bc168644cb0834239302b-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/slirp"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "604f2064f3abc5dce36493c3b872a0ba43bff27b63f573a6eb8c808cde379ebb"
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
