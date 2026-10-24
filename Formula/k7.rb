class K7 < Formula
  desc "Record terminal programs, cram tests and VHS tapes as animated SVG"
  homepage "https://github.com/samoht/ocaml-k7"
  license "ISC"
  url "https://github.com/samoht/ocaml-k7.git", using: :git, branch: "main"
  version "0.9.0"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/k7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "15ea9dda5c31afc17756adbe6b97748477ae4ea3835d14f64c1a6831140fda43"
  end

  head "https://github.com/samoht/ocaml-k7.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build
  depends_on "vhs" => :recommended

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "bin/main.exe"
    bin.install "_build/default/bin/main.exe" => "k7"
  end

  test do
    system bin/"k7", "--help"
  end
end
