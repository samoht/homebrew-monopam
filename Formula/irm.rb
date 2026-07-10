class Irm < Formula
  desc "Content-addressable store with Git support"
  homepage "https://tangled.org/gazagnaire.org/irm"
  license "ISC"
  version "20260710-0112caa9d8f66fe5354e20581a76c9730232e6ad+dirty"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/irm/arm64_sonoma/20260710-0112caa9d8f66fe5354e20581a76c9730232e6ad+dirty.bottle.tar.gz"
      sha256 "c9edc2705875f8b0cd6d37f6ead9d2108c94e4ca0dae0088c155d6dab14811a5"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/irm/sonoma/latest.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/irm/x86_64_linux/latest.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "irmin/bin/main.exe"
      bin.install "_build/default/irmin/bin/main.exe" => "irm"
    else
      bin.install "irm"
    end
  end

  test do
    system bin/"irm", "--help"
  end
end
