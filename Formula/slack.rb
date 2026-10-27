class Slack < Formula
  desc "Slack API command-line client"
  homepage "https://tangled.org/gazagnaire.org/slack"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "b425d98700649f184f63bc7e5a4d1de5acc77546"
  version "20261027-b425d98700649f184f63bc7e5a4d1de5acc77546-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/slack"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "2d2c623ef14584b34a1c3b303c7a78f6188d3ee90e13ce87129060ff337d3ae4"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-slack/bin/main.exe"
    bin.install "_build/default/ocaml-slack/bin/main.exe" => "slack"
  end

  test do
    system bin/"slack", "--help"
  end
end
