class Meross < Formula
  desc "Meross smart plug control and monitoring"
  homepage "https://tangled.org/gazagnaire.org/meross"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "fcfa6a29460bd922549bc168644cb0834239302b"
  version "20260902-fcfa6a29460bd922549bc168644cb0834239302b-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/meross"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "cb95c459c89bc4c892ea1a00618191ee524e49ac0382291ce64f418d30ac4e41"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-meross/bin/main.exe"
    bin.install "_build/default/ocaml-meross/bin/main.exe" => "meross"
  end

  test do
    system bin/"meross", "--help"
  end
end
