class Bottler < Formula
  desc "Homebrew bottle builder and tap manager"
  homepage "https://tangled.org/gazagnaire.org/ocaml-homebrew"
  license "ISC"
  version "20260521-489643a694d6cc53502f2af31b33e64e4a6c45a0"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/bottler/arm64_sonoma/20260521-489643a694d6cc53502f2af31b33e64e4a6c45a0.bottle.tar.gz"
      sha256 "534a4996e698c3609e8b32b309cdc725eb0e5fd94ee8be89d9e9629dce50a7ce"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/bottler-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/bottler-latest.x86_64_linux.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "ocaml-homebrew/bin/main.exe"
      bin.install "_build/default/ocaml-homebrew/bin/main.exe" => "bottler"
    else
      bin.install "bottler"
    end
  end

  test do
    system bin/"bottler", "--help"
  end
end
