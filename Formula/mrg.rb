class Mrg < Formula
  desc "Build and run mirage-eio unikernels across backends"
  homepage "https://tangled.org/gazagnaire.org/mrg"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c9d0aca8fb9be39251315708f223f03adb861eb"
  version "20260730-9c9d0aca8fb9be39251315708f223f03adb861eb-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/mrg"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8959b73b5f262b9cc45413a2072ff282843e45f98b1030aed5aee59139962947"
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
