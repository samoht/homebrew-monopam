class Precommit < Formula
  desc "Pre-commit hook manager for OCaml projects"
  homepage "https://tangled.org/gazagnaire.org/ocaml-precommit"
  license "ISC"
  version "20260206"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/precommit-20260206.arm64_sonoma.bottle.tar.gz"
      sha256 "34aa5b4426b95f0e205f7e744a08248fb240a5c86061b026c5aba91a1da371ca"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/precommit-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/precommit-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "ocaml-precommit/bin/main.exe"
      bin.install "_build/default/ocaml-precommit/bin/main.exe" => "precommit"
    else
      bin.install "precommit"
    end
  end

  test do
    system bin/"precommit", "--help"
  end
end
