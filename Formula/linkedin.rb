class Linkedin < Formula
  desc "LinkedIn CLI for profiles, posts, and cookies"
  homepage "https://tangled.org/gazagnaire.org/linkedin"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "b425d98700649f184f63bc7e5a4d1de5acc77546"
  version "20261027-b425d98700649f184f63bc7e5a4d1de5acc77546-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/linkedin"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "3f7b2efe937d43cba15ca1687b07f6954e7d4dbdc028e14f8f9c87d06335a2fc"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-linkedin/bin/main.exe"
    bin.install "_build/default/ocaml-linkedin/bin/main.exe" => "linkedin"
  end

  test do
    system bin/"linkedin", "--help"
  end
end
