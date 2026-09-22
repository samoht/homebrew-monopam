class Meross < Formula
  desc "Meross smart plug control and monitoring"
  homepage "https://tangled.org/gazagnaire.org/meross"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "bf6f0d85f9a9e95846a70f64248b349745032fe7"
  version "20260922-bf6f0d85f9a9e95846a70f64248b349745032fe7"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/meross"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d2fe092fb5927b1e14e6c7b853201dbdee80daf4f4261e7231467c2274754fb6"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-meross/bin/main.exe"
    bin.install "_build/default/ocaml-meross/bin/main.exe" => "meross"
  end

  test do
    system bin/"meross", "--help"
  end
end
