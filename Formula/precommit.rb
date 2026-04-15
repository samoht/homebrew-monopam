class Precommit < Formula
  desc "Pre-commit hook manager for OCaml projects"
  homepage "https://tangled.org/gazagnaire.org/ocaml-precommit"
  license "ISC"
  version "20260415-259056f"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/precommit-20260415-259056f.arm64_sonoma.bottle.tar.gz"
      sha256 "4f7cbfd7f003b714310cf29eccbe492ae01bbe8235d00a29e52d07a63f76ca9a"
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
