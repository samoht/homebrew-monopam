class Merlint < Formula
  desc "Opinionated OCaml linter powered by Merlin"
  homepage "https://tangled.org/gazagnaire.org/merlint"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "f8d731a16c87a1ef20ba1886e3a9066a2a28d24a"
  version "20261016-f8d731a16c87a1ef20ba1886e3a9066a2a28d24a-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/merlint"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "e4e4e54b379956e31fc852fb2e3a574e81cf1c96207737ced3704ebed78eddbf"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "merlint/bin/main.exe"
    bin.install "_build/default/merlint/bin/main.exe" => "merlint"
  end

  test do
    system bin/"merlint", "--help"
  end
end
