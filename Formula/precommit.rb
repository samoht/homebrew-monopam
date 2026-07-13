class Precommit < Formula
  desc "Pre-commit hook manager for OCaml projects"
  homepage "https://tangled.org/gazagnaire.org/ocaml-precommit"
  license "ISC"
  version "20260713-c37b84fd9695d55de72f4cb56a8c0767239c80c1+dirty"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/precommit/arm64_sonoma/20260713-c37b84fd9695d55de72f4cb56a8c0767239c80c1+dirty.bottle.tar.gz"
      sha256 "b0559fed0b91f03c3d0beafb35efe27a1f7f2f72bfe74212d7377aae0136a149"
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
