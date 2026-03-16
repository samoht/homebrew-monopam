class Uniboot < Formula
  desc "Bootable disk image builder with GPT partition tables"
  homepage "https://tangled.org/gazagnaire.org/uniboot"
  license "ISC"
  version "20260315"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/uniboot-20260315.arm64_sonoma.bottle.tar.gz"
      sha256 "e425bd870922f3710814decbd7b9b99e4db0314046537de42ac1b53c2f8c97aa"
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
