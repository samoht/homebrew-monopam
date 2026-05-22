class Linkedin < Formula
  desc "LinkedIn CLI for profiles, posts, and cookies"
  homepage "https://tangled.org/gazagnaire.org/linkedin"
  license "ISC"
  version "20260522-6c03c071fecb5cf992712aa1335334122fbafdbf"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/linkedin/arm64_sonoma/20260522-6c03c071fecb5cf992712aa1335334122fbafdbf.bottle.tar.gz"
      sha256 "4b4342d78870412a7f4a0a2ba74f9579fc539185b42991657b6c0ed7d8534215"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/linkedin-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/linkedin-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "ocaml-linkedin/bin/main.exe"
      bin.install "_build/default/ocaml-linkedin/bin/main.exe" => "linkedin"
    else
      bin.install "linkedin"
    end
  end

  test do
    system bin/"linkedin", "--help"
  end
end
