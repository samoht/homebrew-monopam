class GitX < Formula
  desc "Fast git operations on the object DB (no checkout)"
  homepage "https://tangled.org/gazagnaire.org/git-x"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "fcfa6a29460bd922549bc168644cb0834239302b"
  version "20260902-fcfa6a29460bd922549bc168644cb0834239302b-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/git-x"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "c54dc33f111aa5881bb696991d6c1b349fa7412b1eb4975532ce7fa11c588511"
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
