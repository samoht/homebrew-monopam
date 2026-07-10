class Uniboot < Formula
  desc "Bootable disk image builder with GPT partition tables"
  homepage "https://tangled.org/gazagnaire.org/uniboot"
  license "ISC"
  version "20260710-0112caa9d8f66fe5354e20581a76c9730232e6ad+dirty"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/uniboot/arm64_sonoma/20260710-0112caa9d8f66fe5354e20581a76c9730232e6ad+dirty.bottle.tar.gz"
      sha256 "1124fd26098e5f1a595a8db606d2566b98b17306aa21af8faabcdad66fd8d557"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/uniboot-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/uniboot-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "uniboot/bin/main.exe"
      bin.install "_build/default/uniboot/bin/main.exe" => "uniboot"
    else
      bin.install "uniboot"
    end
  end

  test do
    system bin/"uniboot", "--help"
  end
end
