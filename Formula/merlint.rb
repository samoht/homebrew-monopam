class Merlint < Formula
  desc "Opinionated OCaml linter powered by Merlin"
  homepage "https://tangled.org/gazagnaire.org/merlint"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c7cfbb598ec5b709439158712db26318961fbe2"
  version "20260904-9c7cfbb598ec5b709439158712db26318961fbe2"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/merlint"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "13c9d1004737084fecae863c36f21200bffea1107fbf674a723ff04375b0ca71"
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
