class Vz < Formula
  desc "Boot a Linux VM with a user-mode slirp network, no sudo"
  homepage "https://tangled.org/gazagnaire.org/vz"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, revision: "9c9d0aca8fb9be39251315708f223f03adb861eb"
  version "20260730-9c9d0aca8fb9be39251315708f223f03adb861eb-dirty"

  bottle do
    root_url "https://homebrew-bottles.s3.fr-par.scw.cloud/vz"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "20932e56707c9908fc989bd899de532a2a42cd8298c3e13460c78c0a79a2e74f"
  end

  head "https://tangled.org/gazagnaire.org/ocaml-git.git", branch: "main"

  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "dune" => :build

  def install
    system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
    system "opam", "install", ".", "--deps-only", "-y", "--working-dir"
    system "opam", "exec", "--", "dune", "build", "ocaml-vz/bin/vz_cli.exe"
    bin.install "_build/default/ocaml-vz/bin/vz_cli.exe" => "vz"
  end

  def post_install
    require "tempfile"
    ent = Tempfile.new("vz.entitlements")
    ent.write <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>com.apple.security.virtualization</key>
        <true/>
      </dict>
      </plist>
    PLIST
    ent.close
    system "codesign", "--force", "--sign", "-", "--entitlements", ent.path, bin/"vz"
    ent.unlink
  end

  test do
    system bin/"vz", "--help"
  end
end
