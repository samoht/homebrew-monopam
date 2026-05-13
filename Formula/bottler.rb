class Bottler < Formula
  desc "Homebrew bottle builder and tap manager"
  homepage "https://tangled.org/gazagnaire.org/ocaml-homebrew"
  license "ISC"
  version "20260513-2fe05c6"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/bottler/arm64_sonoma/20260513-2fe05c6.bottle.tar.gz"
      sha256 "6d3700763ba984c43e633d3ff841c31364268f5a8c45f3f29b1ccf12443c9ebb"
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
