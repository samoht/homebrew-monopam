class Meross < Formula
  desc "Meross smart plug control and monitoring"
  homepage "https://tangled.org/gazagnaire.org/meross"
  license "ISC"
  version "20260315"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/meross-20260315.arm64_sonoma.bottle.tar.gz"
      sha256 "1fd4cb584c3a2fba5684ce3d1cd370e10c18edf5cadd3746968ce3274fffdff4"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/meross-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/meross-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "ocaml-meross/bin/main.exe"
      bin.install "_build/default/ocaml-meross/bin/main.exe" => "meross"
    else
      bin.install "meross"
    end
  end

  test do
    system bin/"meross", "--help"
  end
end
