class Crow < Formula
  desc "Crowbar campaign orchestrator for AFL fuzzing"
  homepage "https://tangled.org/gazagnaire.org/crow"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "fcfa6a29460bd922549bc168644cb0834239302b"
  version "20260902-fcfa6a29460bd922549bc168644cb0834239302b-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/crow"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "fdb14cc4851ec73d5555c82ed79e9e1f54adb318b6eecf3b8de68950e8594f1a"
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
