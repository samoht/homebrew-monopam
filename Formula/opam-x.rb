class OpamX < Formula
  desc "Fast opam operations and cross-compilation toolchains"
  homepage "https://tangled.org/gazagnaire.org/opam-x"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "bf6f0d85f9a9e95846a70f64248b349745032fe7"
  version "20260922-bf6f0d85f9a9e95846a70f64248b349745032fe7"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/opam-x"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b100128a88f0e6f965681cfa0d17dea66156a0d0d55e8ff9bddef39dd62b5405"
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
