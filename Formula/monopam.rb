class Monopam < Formula
  desc "OCaml monorepo manager with git subtrees"
  homepage "https://tangled.org/gazagnaire.org/monopam"
  license "ISC"
  version "20260415-ec0116d"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/monopam-20260415-ec0116d.arm64_sonoma.bottle.tar.gz"
      sha256 "5c034868d44f51e20e79485bcb430c6df7e498f140c7f7e6a945d23894641b69"
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
