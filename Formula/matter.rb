class Matter < Formula
  desc "Matter smart home device discovery and control"
  homepage "https://tangled.org/gazagnaire.org/matter"
  license "ISC"
  version "20260513-3e00f1a"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/matter/arm64_sonoma/20260513-3e00f1a.bottle.tar.gz"
      sha256 "54e77f4e5e15a51c13eab6d0dedee9b7bc1e892355877e5744491092b96b6879"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/matter-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/matter-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "ocaml-matter/bin/matter_cli.exe"
      bin.install "_build/default/ocaml-matter/bin/matter_cli.exe" => "matter"
    else
      bin.install "matter"
    end
  end

  test do
    system bin/"matter", "--help"
  end
end
