class Slirp < Formula
  desc "User-mode network gateway -- no VM, no privilege"
  homepage "https://tangled.org/gazagnaire.org/slirp"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c9d0aca8fb9be39251315708f223f03adb861eb"
  version "20260730-9c9d0aca8fb9be39251315708f223f03adb861eb-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/slirp"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d126c3408beee874caa24976d80c5fa67e9a9d15dab463559f91d61f14cacada"
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
