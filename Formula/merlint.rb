class Merlint < Formula
  desc "Opinionated OCaml linter powered by Merlin"
  homepage "https://tangled.org/gazagnaire.org/merlint"
  license "ISC"
  version "20260424-4aea2b3"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/merlint/arm64_sonoma/20260424-4aea2b3.bottle.tar.gz"
      sha256 "78cba4afda84cf83748564fef2dfd116ce2f3190d5d47bf974b98cc44fab39d4"
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
