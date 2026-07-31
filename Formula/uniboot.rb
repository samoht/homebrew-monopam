class Uniboot < Formula
  desc "Bootable disk image builder"
  homepage "https://tangled.org/gazagnaire.org/uniboot"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c9d0aca8fb9be39251315708f223f03adb861eb"
  version "20260730-9c9d0aca8fb9be39251315708f223f03adb861eb-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/uniboot"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "4f04a0f5133939b455ae02d37525736a8c237205764be0df557e2edc37e446b2"
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
