class Uplink < Formula
  desc "Signed, bandwidth-efficient over-the-air update bundles"
  homepage "https://tangled.org/gazagnaire.org/uplink"
  license "ISC"
  version "20260713-c37b84fd9695d55de72f4cb56a8c0767239c80c1+dirty"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/uplink/arm64_sonoma/20260713-c37b84fd9695d55de72f4cb56a8c0767239c80c1+dirty.bottle.tar.gz"
      sha256 "8339420008391f71aae4f838e0660e8ae69562e20f938968ed8898d4aa5ccddf"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/uplink/sonoma/latest.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/uplink/x86_64_linux/latest.bottle.tar.gz"
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
      system "opam", "exec", "--", "dune", "build", "uplink/bin/main.exe"
      bin.install "_build/default/uplink/bin/main.exe" => "uplink"
    else
      bin.install "uplink"
    end
  end

  test do
    system bin/"uplink", "--help"
  end
end
