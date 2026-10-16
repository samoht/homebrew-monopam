class OpamX < Formula
  desc "Fast opam operations and cross-compilation toolchains"
  homepage "https://tangled.org/gazagnaire.org/opam-x"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "f8d731a16c87a1ef20ba1886e3a9066a2a28d24a"
  version "20261016-f8d731a16c87a1ef20ba1886e3a9066a2a28d24a-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/opam-x"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a19611028e85af780447a68e62d0e9e13c24cb92e41748cd698685b8664f1603"
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
