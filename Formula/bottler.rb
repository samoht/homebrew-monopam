class Bottler < Formula
  desc "Homebrew bottle builder and tap manager"
  homepage "https://tangled.org/gazagnaire.org/bottler"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c9d0aca8fb9be39251315708f223f03adb861eb"
  version "20260730-9c9d0aca8fb9be39251315708f223f03adb861eb-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/bottler"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "7d4b90c3dbd6432414d28824b5690f37ede14d8f7f8c5bc8503cd072300ec73e"
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
