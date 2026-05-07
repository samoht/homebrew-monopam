class Slack < Formula
  desc "Slack API command-line client"
  homepage "https://tangled.org/gazagnaire.org/slack"
  license "ISC"
  version "20260507-6919ee5"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/slack/arm64_sonoma/20260507-6919ee5.bottle.tar.gz"
      sha256 "6a128220594f0e1c3f2ef97ef02ecd8d545b21ed69a2462c79a34dd983f84849"
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
