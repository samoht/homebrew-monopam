class SpaceGround < Formula
  desc "SpaceOS ground station with live web dashboard"
  homepage "https://tangled.org/gazagnaire.org/space-ground"
  license "ISC"
  version "20260415-259056f"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/space-ground-20260415-259056f.arm64_sonoma.bottle.tar.gz"
      sha256 "29c4d8d3e57dc0cd98da712dcb94d61e9dbcd7d83bc70b05042f9288c69b5391"
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
