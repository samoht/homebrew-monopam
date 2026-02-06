class Bottler < Formula
  desc "Homebrew bottle builder and tap manager"
  homepage "https://tangled.org/gazagnaire.org/ocaml-homebrew"
  license "ISC"
  version "20260206"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/bottler-20260206.arm64_sonoma.bottle.tar.gz"
      sha256 "86b801e734558de338930bf7ec69350dd9bf56c0ddb917d90bc218ac6f59b8b0"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/bottler-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/bottler-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "ocaml-homebrew/bin/main.exe"
      bin.install "_build/default/ocaml-homebrew/bin/main.exe" => "bottler"
    else
      bin.install "bottler"
    end
  end

  test do
    system bin/"bottler", "--help"
  end
end
