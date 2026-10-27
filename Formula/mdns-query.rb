class MdnsQuery < Formula
  desc "mDNS service discovery query tool"
  homepage "https://tangled.org/gazagnaire.org/mdns-query"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "b425d98700649f184f63bc7e5a4d1de5acc77546"
  version "20261027-b425d98700649f184f63bc7e5a4d1de5acc77546-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/mdns-query"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b8b9b672f2f53f9df1b419f07dd1a0b7aa1c38bb777d06d247e7e0dda622a297"
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
