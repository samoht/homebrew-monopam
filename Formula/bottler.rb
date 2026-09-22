class Bottler < Formula
  desc "Homebrew bottle builder and tap manager"
  homepage "https://tangled.org/gazagnaire.org/bottler"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "bf6f0d85f9a9e95846a70f64248b349745032fe7"
  version "20260922-bf6f0d85f9a9e95846a70f64248b349745032fe7"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/bottler"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "ba45a3a8196ef0cadacf9ef5a0240d8716672e5e8aa23c86238380a69d42cecb"
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
