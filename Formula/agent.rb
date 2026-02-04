class Agent < Formula
  desc "Claude Code container orchestrator"
  homepage "https://tangled.org/gazagnaire.org/ocaml-agent"
  license "ISC"

  head "https://tangled.org/gazagnaire.org/mono.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build
  depends_on "docker" => :recommended

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "--with-test=false", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-agent/bin/main.exe"
    bin.install "_build/default/ocaml-agent/bin/main.exe" => "agent"
  end

  test do
    system bin/"agent", "--help"
  end
end
