class Slirp < Formula
  desc "User-mode network gateway -- no VM, no privilege"
  homepage "https://tangled.org/gazagnaire.org/slirp"
  license "ISC"
  version "latest"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/slirp/arm64_sonoma/latest.bottle.tar.gz"
      sha256 :no_check
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/slirp/sonoma/latest.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/slirp/x86_64_linux/latest.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "ocaml-slirp/bin/main.exe"
      bin.install "_build/default/ocaml-slirp/bin/main.exe" => "slirp"
    else
      bin.install "slirp"
    end
  end

  test do
    system bin/"slirp", "--help"
  end
end
