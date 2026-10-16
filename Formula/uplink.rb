class Uplink < Formula
  desc "Signed, bandwidth-efficient over-the-air update bundles"
  homepage "https://tangled.org/gazagnaire.org/uplink"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "f8d731a16c87a1ef20ba1886e3a9066a2a28d24a"
  version "20261016-f8d731a16c87a1ef20ba1886e3a9066a2a28d24a-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/uplink"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "09e03f0cb8b1359da0a2454b4b7681048eb3c1f12ab7e1171a72d10bcfbba112"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "uplink/bin/main.exe"
    bin.install "_build/default/uplink/bin/main.exe" => "uplink"
  end

  test do
    system bin/"uplink", "--help"
  end
end
