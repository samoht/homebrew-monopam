class Uplink < Formula
  desc "Signed, bandwidth-efficient over-the-air update bundles"
  homepage "https://tangled.org/gazagnaire.org/uplink"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c7cfbb598ec5b709439158712db26318961fbe2"
  version "20260904-9c7cfbb598ec5b709439158712db26318961fbe2"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/uplink"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "02bedb1c14adb3a56b8b4442646e89ad098abeccffc5a3965924fa5ef50039bb"
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
