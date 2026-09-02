class Slack < Formula
  desc "Slack API command-line client"
  homepage "https://tangled.org/gazagnaire.org/slack"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "fcfa6a29460bd922549bc168644cb0834239302b"
  version "20260902-fcfa6a29460bd922549bc168644cb0834239302b-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/slack"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "cd9e294e1730ada25c41cddecbabf4642f27ef7b85085429f34ed1231ff4fb2e"
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
