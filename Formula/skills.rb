class Skills < Formula
  desc "Claude Code skills manager"
  homepage "https://tangled.org/gazagnaire.org/skills"
  license "ISC"
  version "20260513-bdba8ba"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/skills/arm64_sonoma/20260513-bdba8ba.bottle.tar.gz"
      sha256 "3531c852cbca90875aefc52077ebf1644019bb364b4ca6f79b81ba06fa2ef792"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/skills-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/skills-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "ocaml-claude-skills/bin/main.exe"
      bin.install "_build/default/ocaml-claude-skills/bin/main.exe" => "skills"
    else
      bin.install "skills"
    end
  end

  test do
    system bin/"skills", "--help"
  end
end
