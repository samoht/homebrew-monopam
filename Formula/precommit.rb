class Precommit < Formula
  desc "Pre-commit hook manager for OCaml projects"
  homepage "https://tangled.org/gazagnaire.org/precommit"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "bf6f0d85f9a9e95846a70f64248b349745032fe7"
  version "20260922-bf6f0d85f9a9e95846a70f64248b349745032fe7"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/precommit"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "4b68461974d88162c48f0d61209c33df9cb54ff115e780b43234b7451ab100af"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-precommit/bin/main.exe"
    bin.install "_build/default/ocaml-precommit/bin/main.exe" => "precommit"
  end

  test do
    system bin/"precommit", "--help"
  end
end
