class Uplink < Formula
  desc "Signed, bandwidth-efficient over-the-air update bundles"
  homepage "https://tangled.org/gazagnaire.org/uplink"
  license "ISC"
  version "20260710-0112caa9d8f66fe5354e20581a76c9730232e6ad+dirty"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/uplink/arm64_sonoma/20260710-0112caa9d8f66fe5354e20581a76c9730232e6ad+dirty.bottle.tar.gz"
      sha256 "d5c09f66b61dbdc81f71c593fd4eae9789d17a2ecbaf9adc950b895e6ec781ef"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/uplink/sonoma/latest.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/uplink/x86_64_linux/latest.bottle.tar.gz"
    sha256 :no_check
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  head do
    depends_on "ocaml" => :build
    depends_on "opam" => :build
    depends_on "dune" => :build
  end

  def install
    if build.head?
      system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
      system "opam", "install", ".", "--deps-only", "--with-test=false", "-y", "--working-dir"
      system "opam", "exec", "--", "dune", "build", "uplink/bin/main.exe"
      bin.install "_build/default/uplink/bin/main.exe" => "uplink"
    else
      bin.install "uplink"
    end
  end

  test do
    system bin/"uplink", "--help"
  end
end
