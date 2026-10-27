class Irm < Formula
  desc "Content-addressable store with Git support"
  homepage "https://tangled.org/gazagnaire.org/irm"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "b425d98700649f184f63bc7e5a4d1de5acc77546"
  version "20261027-b425d98700649f184f63bc7e5a4d1de5acc77546-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/irm"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "2a78f9a3f67b3fea555adf1219d0f21c35ec9dc1729d5f5dca954fb4178b9f95"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "irmin/bin/main.exe"
    bin.install "_build/default/irmin/bin/main.exe" => "irm"
  end

  test do
    system bin/"irm", "--help"
  end
end
