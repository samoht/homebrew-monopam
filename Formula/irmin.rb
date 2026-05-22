class Irmin < Formula
  desc "Content-addressable store with Git and ATProto MST support"
  homepage "https://tangled.org/gazagnaire.org/irmin"
  license "ISC"
  version "20260522-76effcb3f05ae4805bf133dfdc71db98ba20b5fa"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/irmin/arm64_sonoma/20260522-76effcb3f05ae4805bf133dfdc71db98ba20b5fa.bottle.tar.gz"
      sha256 "9611c9714c68160660db43ff038a5e2973800e7ccf32dd3e768320804c088d36"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/irmin-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/irmin-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "irmin/bin/irmin.exe"
      bin.install "_build/default/irmin/bin/irmin.exe" => "irmin"
    else
      bin.install "irmin"
    end
  end

  test do
    system bin/"irmin", "--help"
  end
end
