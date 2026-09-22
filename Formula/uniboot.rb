class Uniboot < Formula
  desc "Bootable disk image builder"
  homepage "https://tangled.org/gazagnaire.org/uniboot"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "bf6f0d85f9a9e95846a70f64248b349745032fe7"
  version "20260922-bf6f0d85f9a9e95846a70f64248b349745032fe7"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/uniboot"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "573b579f595d255f5fdf34db62ea57671974118b71d74c048ce6f07c7d5d535d"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "uniboot/bin/main.exe"
    bin.install "_build/default/uniboot/bin/main.exe" => "uniboot"
  end

  test do
    system bin/"uniboot", "--help"
  end
end
