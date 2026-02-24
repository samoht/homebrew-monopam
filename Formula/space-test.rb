class SpaceTest < Formula
  desc "SpaceOS E2E test harness"
  homepage "https://tangled.org/gazagnaire.org/space-test"
  license "ISC"
  version "20260223"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/space-test-20260223.arm64_sonoma.bottle.tar.gz"
      sha256 "b7a809e399d1ebd461504cef5f3e3a2910054e447c922572e30c18a5f67aaa96"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/space-test-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/space-test-latest.x86_64_linux.bottle.tar.gz"
    sha256 :no_check
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  head do
    depends_on "ocaml" => :build
    depends_on "opam" => :build
    depends_on "dune" => :build
    depends_on "qemu" => :recommended
  end

  def install
    if build.head?
      system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
      system "opam", "install", ".", "--deps-only", "--with-test=false", "-y", "--working-dir"
      system "opam", "exec", "--", "dune", "build", "space-test/bin/main.exe"
      bin.install "_build/default/space-test/bin/main.exe" => "space-test"
    else
      bin.install "space-test"
    end
  end

  test do
    system bin/"space-test", "--help"
  end
end
