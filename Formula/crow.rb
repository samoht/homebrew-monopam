class Crow < Formula
  desc "Crowbar campaign orchestrator for AFL fuzzing"
  homepage "https://tangled.org/gazagnaire.org/crow"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "bf6f0d85f9a9e95846a70f64248b349745032fe7"
  version "20260922-bf6f0d85f9a9e95846a70f64248b349745032fe7"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/crow"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "56762d60f0edb6e333522b5d34b8ec2fe397ad07cbcde45b7d80b55f23c7d6a3"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build
  depends_on "afl++" => :recommended

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-crow/bin/main.exe"
    bin.install "_build/default/ocaml-crow/bin/main.exe" => "crow"
  end

  test do
    system bin/"crow", "--help"
  end
end
