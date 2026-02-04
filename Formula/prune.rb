class Prune < Formula
  desc "Find and remove unused exports in OCaml interface files"
  homepage "https://tangled.org/gazagnaire.org/prune"
  license "ISC"

  # Rolling release - always use HEAD
  head "https://tangled.org/gazagnaire.org/mono.git", branch: "main"

  # Or use pre-built bottles (uncomment when bottles are available):
  # url "https://homebrew-bottles.s3.fr-par.scw.cloud/prune-latest.arm64_sonoma.bottle.tar.gz"
  # sha256 :no_check

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    # Initialize opam if needed
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")

    # Install dependencies
    system "opam", "install", ".", "--deps-only", "--with-test=false", "-y", "--working-dir"

    # Build
    system "opam", "exec", "--", "dune", "build", "prune/bin/prune.exe"

    # Install binary
    bin.install "_build/default/prune/bin/prune.exe" => "prune"
  end

  test do
    system bin/"prune", "--help"
  end
end
