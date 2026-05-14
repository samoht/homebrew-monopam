class Skills < Formula
  desc "Claude Code skills manager"
  homepage "https://tangled.org/gazagnaire.org/skills"
  license "ISC"
  version "20260513-3e00f1a"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/skills/arm64_sonoma/20260513-3e00f1a.bottle.tar.gz"
      sha256 "387274a6116fc4f7d22a053302126f65c7bdcd2e5dbb37e90cb501d86d56be48"
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
