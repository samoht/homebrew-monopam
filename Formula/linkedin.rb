class Linkedin < Formula
  desc "LinkedIn CLI for profiles, posts, and cookies"
  homepage "https://tangled.org/gazagnaire.org/linkedin"
  license "ISC"
  version "20260310"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/linkedin-20260310.arm64_sonoma.bottle.tar.gz"
      sha256 "d07750372c9a74ef31b2353b7db7e0116c68f9dcd3e056b5a42fea74f7d18a50"
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
