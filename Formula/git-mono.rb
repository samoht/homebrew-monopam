class GitMono < Formula
  desc "Pure OCaml git subtree split"
  homepage "https://tangled.org/gazagnaire.org/ocaml-git"
  license "ISC"
  version "20260315"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/git-mono-20260315.arm64_sonoma.bottle.tar.gz"
      sha256 "d480c7d5cb12e0bfc2a65ba7d09034ffb41f935b0d227eedddf4c939b8d056cc"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/git-mono-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/git-mono-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "ocaml-git/bin/git_mono.exe"
      bin.install "_build/default/ocaml-git/bin/git_mono.exe" => "git-mono"
    else
      bin.install "git-mono"
    end
  end

  test do
    system bin/"git-mono", "--help"
  end
end
