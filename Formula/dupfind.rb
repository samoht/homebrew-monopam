class Dupfind < Formula
  desc "Find cross-package duplicate code"
  homepage "https://tangled.org/gazagnaire.org/dupfind"
  license "ISC"
  version "20260514-8242967"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/dupfind/arm64_sonoma/20260514-8242967.bottle.tar.gz"
      sha256 "e06a6a326381cb7d8639a1e19825dd6e631ee9cafef0e279d9f090653e2c9ebe"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/dupfind-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/dupfind-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "dupfind/bin/main.exe"
      bin.install "_build/default/dupfind/bin/main.exe" => "dupfind"
    else
      bin.install "dupfind"
    end
  end

  test do
    system bin/"dupfind", "--help"
  end
end
