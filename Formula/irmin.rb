class Irmin < Formula
  desc "Content-addressable store with Git and ATProto MST support"
  homepage "https://tangled.org/gazagnaire.org/irmin"
  license "ISC"

  head "https://tangled.org/gazagnaire.org/mono.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "--with-test=false", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "irmin/bin/irmin.exe"
    bin.install "_build/default/irmin/bin/irmin.exe" => "irmin"
  end

  test do
    system bin/"irmin", "--help"
  end
end
