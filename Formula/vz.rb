class Vz < Formula
  desc "Boot a Linux VM with a user-mode slirp network, no sudo"
  homepage "https://tangled.org/gazagnaire.org/vz"
  license "ISC"
  version "latest"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/vz/arm64_sonoma/latest.bottle.tar.gz"
      sha256 :no_check
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/vz/sonoma/latest.bottle.tar.gz"
      sha256 :no_check
    end
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
      system "opam", "exec", "--", "dune", "build", "ocaml-vz/bin/vz_cli.exe"
      bin.install "_build/default/ocaml-vz/bin/vz_cli.exe" => "vz"
    else
      bin.install "vz"
    end
      (buildpath/"vz.entitlements").write <<~PLIST
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
        <key>com.apple.security.virtualization</key>
        <true/>
        </dict>
        </plist>
      PLIST
      system "codesign", "--force", "--sign", "-", "--entitlements", buildpath/"vz.entitlements", bin/"vz"
  end

  test do
    system bin/"vz", "--help"
  end
end
