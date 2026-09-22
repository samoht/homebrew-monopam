class Mrg < Formula
  desc "Build and run mirage-eio unikernels across backends"
  homepage "https://tangled.org/gazagnaire.org/mrg"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "bf6f0d85f9a9e95846a70f64248b349745032fe7"
  version "20260922-bf6f0d85f9a9e95846a70f64248b349745032fe7"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/mrg"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d41ad5f27101a6051a2b29cec78193626f04953a27bc5b36b8c5ac0e5ea44a25"
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
