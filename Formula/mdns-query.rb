class MdnsQuery < Formula
  desc "mDNS service discovery query tool"
  homepage "https://tangled.org/gazagnaire.org/ocaml-mdns"
  license "ISC"
  version "20260522-76effcb3f05ae4805bf133dfdc71db98ba20b5fa"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/mdns-query/arm64_sonoma/20260522-76effcb3f05ae4805bf133dfdc71db98ba20b5fa.bottle.tar.gz"
      sha256 "312fd8a4bf5ba3c346fc24dae39519aee2ac4c6020a014ebb1952b5410f14d78"
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
