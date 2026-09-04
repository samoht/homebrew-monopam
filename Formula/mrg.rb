class Mrg < Formula
  desc "Build and run mirage-eio unikernels across backends"
  homepage "https://tangled.org/gazagnaire.org/mrg"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c7cfbb598ec5b709439158712db26318961fbe2"
  version "20260904-9c7cfbb598ec5b709439158712db26318961fbe2"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/mrg"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "92df7a29f00c0de10b7dfe91a94c7aecf47a61c18d86c0f71ff53c93c617051f"
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
