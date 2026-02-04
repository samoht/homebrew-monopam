class Uniboot < Formula
  desc "Bootable disk image builder with GPT partition tables"
  homepage "https://tangled.org/gazagnaire.org/uniboot"
  license "ISC"

  head "https://tangled.org/gazagnaire.org/mono.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "--with-test=false", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "uniboot/bin/main.exe"
    bin.install "_build/default/uniboot/bin/main.exe" => "uniboot"
  end

  test do
    system bin/"uniboot", "--help"
  end
end
