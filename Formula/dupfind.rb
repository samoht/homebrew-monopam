class Dupfind < Formula
  desc "Find cross-package duplicate code"
  homepage "https://tangled.org/gazagnaire.org/dupfind"
  license "ISC"
  version "20260319"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/dupfind-20260319.arm64_sonoma.bottle.tar.gz"
      sha256 "e094f3acb1dd04ca8f7e09ee8a345c5b3d9e7d2f992d368a829fe97837d2088d"
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
