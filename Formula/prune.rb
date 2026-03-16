class Prune < Formula
  desc "Find and remove unused exports in OCaml interface files"
  homepage "https://tangled.org/gazagnaire.org/prune"
  license "ISC"
  version "20260315"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/prune-20260315.arm64_sonoma.bottle.tar.gz"
      sha256 "0fec2380d7a92fd361525d1c9ae53b8ac50e8887582d8b1e62e89c1ab12a7f55"
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
