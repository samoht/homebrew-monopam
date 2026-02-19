class GitMono < Formula
  desc "Pure OCaml git subtree split"
  homepage "https://tangled.org/gazagnaire.org/ocaml-git"
  license "ISC"
  version "20260218"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/git-mono-20260218.arm64_sonoma.bottle.tar.gz"
      sha256 "d601e3cec2784d0f4deca515b98eb48d1a561a881097107a93fe84a11bd16bc7"
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
