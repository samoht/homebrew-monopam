class Precommit < Formula
  desc "Pre-commit hook manager for OCaml projects"
  homepage "https://tangled.org/gazagnaire.org/precommit"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "b425d98700649f184f63bc7e5a4d1de5acc77546"
  version "20261027-b425d98700649f184f63bc7e5a4d1de5acc77546-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/precommit"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "3c7ced15b00bbde2746087e94342e1403a77a09b7a3583aca2a118e8693ab16e"
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
