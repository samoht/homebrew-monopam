class Mrg < Formula
  desc "Build and run mirage-eio unikernels across backends"
  homepage "https://tangled.org/gazagnaire.org/mrg"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "b425d98700649f184f63bc7e5a4d1de5acc77546"
  version "20261027-b425d98700649f184f63bc7e5a4d1de5acc77546-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/mrg"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "6014232be61ad88b5edf595fbe487354393c0f12ae966ea0af003c0cc187a9f5"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "mirage/bin/main.exe"
    bin.install "_build/default/mirage/bin/main.exe" => "mrg"
  end

  test do
    system bin/"mrg", "--help"
  end
end
