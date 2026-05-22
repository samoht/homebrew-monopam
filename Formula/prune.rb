class Prune < Formula
  desc "Find and remove unused exports in OCaml interface files"
  homepage "https://tangled.org/gazagnaire.org/prune"
  license "ISC"
  version "20260522-6c03c071fecb5cf992712aa1335334122fbafdbf"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/prune/arm64_sonoma/20260522-6c03c071fecb5cf992712aa1335334122fbafdbf.bottle.tar.gz"
      sha256 "29e68d2d242ac4ea24182d33a6a7dc36e3e533e39192c9f187a0a1f3972edfa2"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/prune-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/prune-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "prune/bin/prune.exe"
      bin.install "_build/default/prune/bin/prune.exe" => "prune"
    else
      bin.install "prune"
    end
  end

  test do
    system bin/"prune", "--help"
  end
end
