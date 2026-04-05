class SpaceGround < Formula
  desc "SpaceOS ground station with live web dashboard"
  homepage "https://tangled.org/gazagnaire.org/space-ground"
  license "ISC"
  version "20260404-1ccd99f"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/space-ground-20260404-1ccd99f.arm64_sonoma.bottle.tar.gz"
      sha256 "d439dfe55354d4084056fc83e5f3a244d2f2dcd6c1fc0b26cae172cfb4686a8d"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/space-ground-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/space-ground-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "space-ground/bin/main.exe"
      bin.install "_build/default/space-ground/bin/main.exe" => "space-ground"
    else
      bin.install "space-ground"
    end
  end

  test do
    system bin/"space-ground", "--help"
  end
end
