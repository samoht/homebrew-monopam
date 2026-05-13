class Slack < Formula
  desc "Slack API command-line client"
  homepage "https://tangled.org/gazagnaire.org/slack"
  license "ISC"
  version "20260513-2fe05c6"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/slack/arm64_sonoma/20260513-2fe05c6.bottle.tar.gz"
      sha256 "d4b0858c223c387383ad0be98137aa8d3c74f05e2a50897794d77d97451b374e"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/slack-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/slack-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "ocaml-slack/bin/main.exe"
      bin.install "_build/default/ocaml-slack/bin/main.exe" => "slack"
    else
      bin.install "slack"
    end
  end

  test do
    system bin/"slack", "--help"
  end
end
