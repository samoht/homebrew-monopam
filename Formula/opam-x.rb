class OpamX < Formula
  desc "Fast opam operations and cross-compilation toolchains"
  homepage "https://tangled.org/gazagnaire.org/opam-x"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "b425d98700649f184f63bc7e5a4d1de5acc77546"
  version "20261027-b425d98700649f184f63bc7e5a4d1de5acc77546-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/opam-x"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "aa25fdbb92e3532d42375e418c57d780f07220b5f2efa886d20072b48aca6f12"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "opam-x/bin/main.exe"
    bin.install "_build/default/opam-x/bin/main.exe" => "opam-x"
  end

  test do
    system bin/"opam-x", "--help"
  end
end
