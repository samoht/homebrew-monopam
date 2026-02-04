class Crow < Formula
  desc "Crowbar campaign orchestrator for AFL fuzzing"
  homepage "https://tangled.org/gazagnaire.org/ocaml-crow"
  license "ISC"

  head "https://tangled.org/gazagnaire.org/mono.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build
  depends_on "afl-fuzz" => :recommended

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "--with-test=false", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-crow/bin/crow.exe"
    bin.install "_build/default/ocaml-crow/bin/crow.exe" => "crow"
  end

  test do
    system bin/"crow", "--help"
  end
end
