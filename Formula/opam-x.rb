class OpamX < Formula
  desc "Fast opam operations and cross-compilation toolchains"
  homepage "https://tangled.org/gazagnaire.org/opam-x"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c9d0aca8fb9be39251315708f223f03adb861eb"
  version "20260730-9c9d0aca8fb9be39251315708f223f03adb861eb-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/opam-x"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "f54cd8b0e685b71dec61c05baca7d570dfd9e0aef0cd30aa936aadcd39c61936"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "opam-x/bin/main.exe"
    bin.install "_build/default/opam-x/bin/main.exe" => "opam-x"
  end

  test do
    system bin/"opam-x", "--help"
  end
end
