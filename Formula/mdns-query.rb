class MdnsQuery < Formula
  desc "mDNS service discovery query tool"
  homepage "https://tangled.org/gazagnaire.org/ocaml-mdns"
  license "ISC"

  head "https://tangled.org/gazagnaire.org/mono.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "--with-test=false", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-mdns/bin/mdns_query.exe"
    bin.install "_build/default/ocaml-mdns/bin/mdns_query.exe" => "mdns-query"
  end

  test do
    system bin/"mdns-query", "--help"
  end
end
