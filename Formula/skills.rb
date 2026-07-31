class Skills < Formula
  desc "Claude Code skills manager"
  homepage "https://tangled.org/gazagnaire.org/skills"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c9d0aca8fb9be39251315708f223f03adb861eb"
  version "20260730-9c9d0aca8fb9be39251315708f223f03adb861eb-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/skills"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "5927d5a1af49d4e39292ca6227b9f286af5f25a43b220c80601a85bbbfa3e953"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-claude-skills/bin/main.exe"
    bin.install "_build/default/ocaml-claude-skills/bin/main.exe" => "skills"
  end

  test do
    system bin/"skills", "--help"
  end
end
