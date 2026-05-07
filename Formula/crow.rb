class Crow < Formula
  desc "Crowbar campaign orchestrator for AFL fuzzing"
  homepage "https://tangled.org/gazagnaire.org/ocaml-crow"
  license "ISC"
  version "20260507-6919ee5"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/crow/arm64_sonoma/20260507-6919ee5.bottle.tar.gz"
      sha256 "70f07aa339e281007a33dc7b07863f7071a5ec1235639c06ff03f56d0824a667"
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
