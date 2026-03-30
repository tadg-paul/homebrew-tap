class Sanitize < Formula
  desc "Fast CLI tool for converting English text to Oxford (OED) spelling"
  homepage "https://github.com/tigger04/british-english-oed-fix"
  url "https://github.com/tigger04/british-english-oed-fix/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "ea211b10e643c74a1357436334c90869e0e5c1b1bf1a0565c69a7bc3a661f69a"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-X main.version=0.3.0", "-o", bin/"sanitize", "./cmd/sanitize/"
  end

  test do
    assert_match "sanitize", shell_output("#{bin}/sanitize --version")
    output = pipe_output("#{bin}/sanitize oed -q", "organise the center")
    assert_equal "organize the centre", output.strip
  end
end
