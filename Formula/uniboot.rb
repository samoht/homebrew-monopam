class Uniboot < Formula
  desc "Bootable disk image builder"
  homepage "https://tangled.org/gazagnaire.org/uniboot"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c7cfbb598ec5b709439158712db26318961fbe2"
  version "20260904-9c7cfbb598ec5b709439158712db26318961fbe2"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/uniboot"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "2137c739011d892111b76829340e6444a6767098db94af396f570735f2bb925f"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "uniboot/bin/main.exe"
    bin.install "_build/default/uniboot/bin/main.exe" => "uniboot"
  end

  test do
    system bin/"uniboot", "--help"
  end
end
