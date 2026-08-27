class Merlint < Formula
  desc "Opinionated OCaml linter powered by Merlin"
  homepage "https://tangled.org/gazagnaire.org/merlint"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "394210fc3ce8238400914db81182ba257f0ac02c"
  version "20260827-394210fc3ce8238400914db81182ba257f0ac02c"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/merlint"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "1aeedd39789caf02327c655b822d00309ee8a37a721e69cdfbfa853f3284c198"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "merlint/bin/main.exe"
    bin.install "_build/default/merlint/bin/main.exe" => "merlint"
  end

  test do
    system bin/"merlint", "--help"
  end
end
