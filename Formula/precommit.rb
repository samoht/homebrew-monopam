class Precommit < Formula
  desc "Pre-commit hook manager for OCaml projects"
  homepage "https://tangled.org/gazagnaire.org/ocaml-precommit"
  license "ISC"
  version "20260421-unknown"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/precommit/arm64_sonoma/20260421-unknown.bottle.tar.gz"
      sha256 "0c395e129a3611c0179f1a020439a156f3d809e0747637ed2a62f4839094e2d9"
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
