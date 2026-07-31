class Slack < Formula
  desc "Slack API command-line client"
  homepage "https://tangled.org/gazagnaire.org/slack"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c9d0aca8fb9be39251315708f223f03adb861eb"
  version "20260730-9c9d0aca8fb9be39251315708f223f03adb861eb-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/slack"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "73e3d44a084186e2428388fa7997d85926aceabce00339cba72d658b3ac86986"
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
