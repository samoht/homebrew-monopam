class MdnsQuery < Formula
  desc "mDNS service discovery query tool"
  homepage "https://tangled.org/gazagnaire.org/ocaml-mdns"
  license "ISC"
  version "20260421-unknown"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/mdns-query/arm64_sonoma/20260421-unknown.bottle.tar.gz"
      sha256 "f534b63a4d7a1756c60e1419286104b983f869c30059b13846788664a092f861"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/mdns-query-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/mdns-query-latest.x86_64_linux.bottle.tar.gz"
    sha256 :no_check
  end

  head "https://tangled.org/gazagnaire.org/mono.git", branch: "main"

  head do
    depends_on "ocaml" => :build
    depends_on "opam" => :build
    depends_on "dune" => :build
  end

  def install
    if build.head?
      system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
      system "opam", "install", ".", "--deps-only", "--with-test=false", "-y", "--working-dir"
      system "opam", "exec", "--", "dune", "build", "ocaml-mdns/bin/mdns_query.exe"
      bin.install "_build/default/ocaml-mdns/bin/mdns_query.exe" => "mdns-query"
    else
      bin.install "mdns-query"
    end
  end

  test do
    system bin/"mdns-query", "--help"
  end
end
