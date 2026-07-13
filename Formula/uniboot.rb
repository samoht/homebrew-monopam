class Uniboot < Formula
  desc "Bootable disk image builder with GPT partition tables"
  homepage "https://tangled.org/gazagnaire.org/uniboot"
  license "ISC"
  version "20260713-c37b84fd9695d55de72f4cb56a8c0767239c80c1+dirty"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/uniboot/arm64_sonoma/20260713-c37b84fd9695d55de72f4cb56a8c0767239c80c1+dirty.bottle.tar.gz"
      sha256 "708ffb6b163720efe2cb6369ab0ced704ec4087500b6d878db1b1c551e776199"
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
