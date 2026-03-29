class Sanitize < Formula
  desc "Fast CLI tool for converting English text to Oxford (OED) spelling"
  homepage "https://github.com/tigger04/british-english-oed-fix"
  url "https://github.com/tigger04/british-english-oed-fix/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "da321ca7996ae89858a7a78ce614a2a990cd540e31c4b08467b423f2b78fd538"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-X main.version=0.2.0", "-o", bin/"sanitize", "./cmd/sanitize/"
  end

  test do
    assert_match "sanitize", shell_output("#{bin}/sanitize --version")
    output = pipe_output("#{bin}/sanitize oed -q", "organise the center")
    assert_equal "organize the centre", output.strip
  end
end
