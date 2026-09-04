class Bottler < Formula
  desc "Homebrew bottle builder and tap manager"
  homepage "https://tangled.org/gazagnaire.org/bottler"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c7cfbb598ec5b709439158712db26318961fbe2"
  version "20260904-9c7cfbb598ec5b709439158712db26318961fbe2"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/bottler"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "511f19fcfb26b459df88365ed44233dc83a91bdab74df8b39c6ffc5bc12ffa4b"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "bottler/bin/main.exe"
    bin.install "_build/default/bottler/bin/main.exe" => "bottler"
  end

  test do
    system bin/"bottler", "--help"
  end
end
