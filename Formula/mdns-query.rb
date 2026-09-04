class MdnsQuery < Formula
  desc "mDNS service discovery query tool"
  homepage "https://tangled.org/gazagnaire.org/mdns-query"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c7cfbb598ec5b709439158712db26318961fbe2"
  version "20260904-9c7cfbb598ec5b709439158712db26318961fbe2"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/mdns-query"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "c9dfd558d26ebfffab00187e472883a242cfb2b4a1a5ca28252ddaff07d50ba9"
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
