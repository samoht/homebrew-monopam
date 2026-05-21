class Uniboot < Formula
  desc "Bootable disk image builder with GPT partition tables"
  homepage "https://tangled.org/gazagnaire.org/uniboot"
  license "ISC"
  version "20260521-489643a694d6cc53502f2af31b33e64e4a6c45a0"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/uniboot/arm64_sonoma/20260521-489643a694d6cc53502f2af31b33e64e4a6c45a0.bottle.tar.gz"
      sha256 "fd59f5600eae0572eb584ec53aad7a5de7a5fcbcc90c245e9ade97790473ab7e"
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
