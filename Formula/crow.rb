class Crow < Formula
  desc "Crowbar campaign orchestrator for AFL fuzzing"
  homepage "https://tangled.org/gazagnaire.org/ocaml-crow"
  license "ISC"
  version "20260513-2fe05c6"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/crow/arm64_sonoma/20260513-2fe05c6.bottle.tar.gz"
      sha256 "5dce1d14184d410e73dacb130152d2dee24920f6f957948fa95eb1c012a5feb8"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/crow-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/crow-latest.x86_64_linux.bottle.tar.gz"
    sha256 :no_check
  end

  head "https://tangled.org/gazagnaire.org/mono.git", branch: "main"

  head do
    depends_on "ocaml" => :build
    depends_on "opam" => :build
    depends_on "dune" => :build
    depends_on "afl-fuzz" => :recommended
  end

  def install
    if build.head?
      system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
      system "opam", "install", ".", "--deps-only", "--with-test=false", "-y", "--working-dir"
      system "opam", "exec", "--", "dune", "build", "ocaml-crow/bin/crow.exe"
      bin.install "_build/default/ocaml-crow/bin/crow.exe" => "crow"
    else
      bin.install "crow"
    end
  end

  test do
    system bin/"crow", "--help"
  end
end
