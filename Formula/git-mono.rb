class GitMono < Formula
  desc "Pure OCaml git subtree split"
  homepage "https://tangled.org/gazagnaire.org/ocaml-git"
  license "ISC"
  url "https://tangled.org/gazagnaire.org/ocaml-git.git", using: :git, branch: "main"
  version "20260415-1d4ee03"

  disable! date: "2026-04-15", because: "is no longer built from this monorepo"

  def install
  end

  test do
  end
end
