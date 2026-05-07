class Merlint < Formula
  desc "Opinionated OCaml linter powered by Merlin"
  homepage "https://tangled.org/gazagnaire.org/merlint"
  license "ISC"
  version "20260507-b902a25"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/merlint/arm64_sonoma/20260507-b902a25.bottle.tar.gz"
      sha256 "9b95ef51b8fd2fe763bc8e9e2d5fcfb94255ba6cf68725b7cc156e765cd29011"
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
