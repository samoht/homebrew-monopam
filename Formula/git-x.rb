class GitX < Formula
  desc "Fast git operations on the object DB (no checkout)"
  homepage "https://tangled.org/gazagnaire.org/git-x"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "f8d731a16c87a1ef20ba1886e3a9066a2a28d24a"
  version "20261016-f8d731a16c87a1ef20ba1886e3a9066a2a28d24a-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/git-x"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "867142298e51510e2a52e23296666609215fa61d28e50f82549c78365e557fcb"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-git/bin/git_x.exe"
    bin.install "_build/default/ocaml-git/bin/git_x.exe" => "git-x"
  end

  test do
    system bin/"git-x", "--help"
  end
end
