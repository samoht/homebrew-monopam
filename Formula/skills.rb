class Skills < Formula
  desc "Claude Code skills manager"
  homepage "https://tangled.org/gazagnaire.org/skills"
  license "ISC"
  version "20260521-489643a694d6cc53502f2af31b33e64e4a6c45a0"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/skills/arm64_sonoma/20260521-489643a694d6cc53502f2af31b33e64e4a6c45a0.bottle.tar.gz"
      sha256 "7fa1806d56d3f2f8d63d828a194337c75fabfeaee2b1cfb717a032a292a7feeb"
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
