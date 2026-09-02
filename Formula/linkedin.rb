class Linkedin < Formula
  desc "LinkedIn CLI for profiles, posts, and cookies"
  homepage "https://tangled.org/gazagnaire.org/linkedin"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "fcfa6a29460bd922549bc168644cb0834239302b"
  version "20260902-fcfa6a29460bd922549bc168644cb0834239302b-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/linkedin"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d7c3f8f26af5cfa9e360c2b5b41f7d0b667cb3dd90e531a679c9ffa55429142f"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-linkedin/bin/main.exe"
    bin.install "_build/default/ocaml-linkedin/bin/main.exe" => "linkedin"
  end

  test do
    system bin/"linkedin", "--help"
  end
end
