class Matter < Formula
  desc "Matter smart home device discovery and control"
  homepage "https://tangled.org/gazagnaire.org/matter"
  license "ISC"
  version "20260421-unknown"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/matter/arm64_sonoma/20260421-unknown.bottle.tar.gz"
      sha256 "134402c8c45ed637bee2868e93bb9309976b171679615c5040acbbf5ed17f63d"
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
