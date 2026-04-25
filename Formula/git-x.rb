class GitX < Formula
  desc "Fast git operations on the object DB (no checkout)"
  homepage "https://tangled.org/gazagnaire.org/git-x"
  license "ISC"
  version "20260424-4aea2b3"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/git-x/arm64_sonoma/20260424-4aea2b3.bottle.tar.gz"
      sha256 "1774d51fbdb1390c5a94d39eb7431dd3b0cb3ee50b9403412b229b2fa842ada3"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/git-x/sonoma/latest.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/git-x/x86_64_linux/latest.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "ocaml-git/bin/git_x.exe"
      bin.install "_build/default/ocaml-git/bin/git_x.exe" => "git-x"
    else
      bin.install "git-x"
    end
  end

  test do
    system bin/"git-x", "--help"
  end
end
