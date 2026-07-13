class Monopam < Formula
  desc "OCaml monorepo manager with git subtrees"
  homepage "https://tangled.org/gazagnaire.org/monopam"
  license "ISC"
  version "20260713-c37b84fd9695d55de72f4cb56a8c0767239c80c1+dirty"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/monopam/arm64_sonoma/20260713-c37b84fd9695d55de72f4cb56a8c0767239c80c1+dirty.bottle.tar.gz"
      sha256 "5bba8462e15e6eb488fe9246f7b48b64fa4c6d54e57d1f5519de18f4666c603e"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/monopam-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/monopam-latest.x86_64_linux.bottle.tar.gz"
    sha256 :no_check
  end

  head "https://tangled.org/gazagnaire.org/mono.git", branch: "main"

  head do
    depends_on "ocaml" => :build
    depends_on "opam" => :build
    depends_on "dune" => :build
  end

  def install
    if build.head?
      system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
      system "opam", "install", ".", "--deps-only", "--with-test=false", "-y", "--working-dir"
      system "opam", "exec", "--", "dune", "build", "monopam/bin/main.exe"
      bin.install "_build/default/monopam/bin/main.exe" => "monopam"
    else
      bin.install "monopam"
    end
  end

  test do
    system bin/"monopam", "--help"
  end
end
