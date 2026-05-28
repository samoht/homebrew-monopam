class Merlint < Formula
  desc "Opinionated OCaml linter powered by Merlin"
  homepage "https://tangled.org/gazagnaire.org/merlint"
  license "ISC"
  version "20260527-cc1dd43a9b36ea415096c75363ab09a8033492cb+dirty"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/merlint/arm64_sonoma/20260527-cc1dd43a9b36ea415096c75363ab09a8033492cb+dirty.bottle.tar.gz"
      sha256 "82fbff16e8ea27ccfb8eb2501915c2aa196658bcd84c35ce0ec8c78623a605e8"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/merlint-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/merlint-latest.x86_64_linux.bottle.tar.gz"
    sha256 :no_check
  end

  # Build from source with --HEAD
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
      system "opam", "exec", "--", "dune", "build", "merlint/bin/main.exe"
      bin.install "_build/default/merlint/bin/main.exe" => "merlint"
    else
      bin.install "merlint"
    end
  end

  test do
    system bin/"merlint", "--help"
  end
end
