class Linkedin < Formula
  desc "LinkedIn CLI for profiles, posts, and cookies"
  homepage "https://tangled.org/gazagnaire.org/linkedin"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "f8d731a16c87a1ef20ba1886e3a9066a2a28d24a"
  version "20261016-f8d731a16c87a1ef20ba1886e3a9066a2a28d24a-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/linkedin"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a3dff5e52128ed7404443a85e1e9c107ed23612fbb02b34a53879850b7982e2e"
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
