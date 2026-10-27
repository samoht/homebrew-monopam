class Uniboot < Formula
  desc "Bootable disk image builder"
  homepage "https://tangled.org/gazagnaire.org/uniboot"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "b425d98700649f184f63bc7e5a4d1de5acc77546"
  version "20261027-b425d98700649f184f63bc7e5a4d1de5acc77546-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/uniboot"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "5c9f14499911b8d4b3df3ecbd2237529c0aa1a3e5f6b547663eef0bc447c8833"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "uniboot/bin/main.exe"
    bin.install "_build/default/uniboot/bin/main.exe" => "uniboot"
  end

  test do
    system bin/"uniboot", "--help"
  end
end
