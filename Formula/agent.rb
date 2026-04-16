class Agent < Formula
  desc "Claude Code container orchestrator"
  homepage "https://tangled.org/gazagnaire.org/ocaml-agent"
  license "ISC"
  version "20260415-1d4ee03"

  on_macos do
    on_arm do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/agent-20260415-1d4ee03.arm64_sonoma.bottle.tar.gz"
      sha256 "8bac805e8d522231470a32196cb49c3eb62c82a7de34dced2d51be772d6fee32"
    end
    on_intel do
      url "https://homebrew-bottles.s3.fr-par.scw.cloud/agent-latest.sonoma.bottle.tar.gz"
      sha256 :no_check
    end
  end

  on_linux do
    url "https://homebrew-bottles.s3.fr-par.scw.cloud/agent-latest.x86_64_linux.bottle.tar.gz"
    sha256 :no_check
  end

  head "https://tangled.org/gazagnaire.org/mono.git", branch: "main"

  head do
    depends_on "ocaml" => :build
    depends_on "opam" => :build
    depends_on "dune" => :build
    depends_on "docker" => :recommended
  end

  def install
    if build.head?
      system "opam", "init", "--disable-sandboxing", "--no-setup", "-y" unless File.exist?("#{Dir.home}/.opam")
      system "opam", "install", ".", "--deps-only", "--with-test=false", "-y", "--working-dir"
      system "opam", "exec", "--", "dune", "build", "ocaml-agent/bin/main.exe"
      bin.install "_build/default/ocaml-agent/bin/main.exe" => "agent"
    else
      bin.install "agent"
    end
  end

  test do
    system bin/"agent", "--help"
  end
end
