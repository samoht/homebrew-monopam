class MdnsQuery < Formula
  desc "mDNS service discovery query tool"
  homepage "https://tangled.org/gazagnaire.org/ocaml-mdns"
  license "ISC"
  version "20260206"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/mdns-query-20260206.arm64_sonoma.bottle.tar.gz"
      sha256 "8104033cdd85934f29156b8f5cf20fc73b82be1a5345f53bd46fc0f472bf3f42"
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
