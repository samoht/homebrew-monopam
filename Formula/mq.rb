class Mq < Formula
  desc "Local merge queue with content-bound gate verdicts"
  homepage "https://tangled.org/gazagnaire.org/mq"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "f8d731a16c87a1ef20ba1886e3a9066a2a28d24a"
  version "20261016-f8d731a16c87a1ef20ba1886e3a9066a2a28d24a-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/mq"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "703072065acd801e53f0d5dfaf61a8d53d6b12530ce306227ec4b48c1ceecfab"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-merge-queue/bin/main.exe"
    bin.install "_build/default/ocaml-merge-queue/bin/main.exe" => "mq"
  end

  test do
    system bin/"mq", "--help"
  end
end
