class MdnsQuery < Formula
  desc "mDNS service discovery query tool"
  homepage "https://tangled.org/gazagnaire.org/mdns-query"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "bf6f0d85f9a9e95846a70f64248b349745032fe7"
  version "20260922-bf6f0d85f9a9e95846a70f64248b349745032fe7"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/mdns-query"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "dbee3aef717b6632c5c877e3b201ff39132bae550b19181050f45cd02735676b"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-mdns/bin/mdns_query.exe"
    bin.install "_build/default/ocaml-mdns/bin/mdns_query.exe" => "mdns-query"
  end

  test do
    system bin/"mdns-query", "--help"
  end
end
