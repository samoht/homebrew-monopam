class Skills < Formula
  desc "Claude Code skills manager"
  homepage "https://tangled.org/gazagnaire.org/skills"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "bf6f0d85f9a9e95846a70f64248b349745032fe7"
  version "20260922-bf6f0d85f9a9e95846a70f64248b349745032fe7"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/skills"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "3be44cc3604e4bf34120a897e52b57b0bc044700a3ba56311129eea772e004c8"
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
