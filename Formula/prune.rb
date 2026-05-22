class Prune < Formula
  desc "Find and remove unused exports in OCaml interface files"
  homepage "https://tangled.org/gazagnaire.org/prune"
  license "ISC"
  version "20260522-76effcb3f05ae4805bf133dfdc71db98ba20b5fa"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/prune/arm64_sonoma/20260522-76effcb3f05ae4805bf133dfdc71db98ba20b5fa.bottle.tar.gz"
      sha256 "90b2293446474d1689aa7e16ad86724d83d960e52cafae8cd78d2a4cf12420a1"
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
