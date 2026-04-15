class Dupfind < Formula
  desc "Find cross-package duplicate code"
  homepage "https://tangled.org/gazagnaire.org/dupfind"
  license "ISC"
  version "20260415-259056f"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/dupfind-20260415-259056f.arm64_sonoma.bottle.tar.gz"
      sha256 "b6cb7bbe1b2668f986fa65f8734f380608a3b8b3d864495a11cc4e6dfbf09b13"
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
