class Pruner < Formula
  desc "Dead code remover for OCaml .mli files"
  homepage "https://tangled.org/gazagnaire.org/prune"
  license "ISC"
  version "20260208"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/pruner-20260208.arm64_sonoma.bottle.tar.gz"
      sha256 "ff940c57bff1dd7b2c761367161f86aa542fc18d6ad0b980a1ab8e06252e4d09"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/pruner-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/pruner-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "prune/bin/prune.exe"
      bin.install "_build/default/prune/bin/prune.exe" => "pruner"
    else
      bin.install "pruner"
    end
  end

  test do
    system bin/"pruner", "--help"
  end
end
