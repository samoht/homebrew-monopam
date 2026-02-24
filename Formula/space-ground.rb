class SpaceGround < Formula
  desc "SpaceOS ground station with live web dashboard"
  homepage "https://tangled.org/gazagnaire.org/space-ground"
  license "ISC"
  version "20260223"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/space-ground-20260223.arm64_sonoma.bottle.tar.gz"
      sha256 "2e5d3f29f409f2cbb896557a2f368db693256516adb7dff179fb68c879e52b14"
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
