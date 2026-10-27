class Mq < Formula
  desc "Local merge queue with content-bound gate verdicts"
  homepage "https://tangled.org/gazagnaire.org/mq"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "b425d98700649f184f63bc7e5a4d1de5acc77546"
  version "20261027-b425d98700649f184f63bc7e5a4d1de5acc77546-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/mq"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "0827a5302af68271bd30c5214f65ebd12cf853b7217418dca0a96fd43725c00b"
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
