class OedSanitize < Formula
  desc "Fast CLI tool for converting English text to Oxford (OED) spelling"
  homepage "https://github.com/tigger04/oed-sanitize"
  url "https://github.com/tigger04/oed-sanitize/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "123a469173fcf8420afd998de52cd1bccd7ef78f5fdd6b56e177b1e3858d7ecc"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-X main.version=0.4.0", "-o", bin/"sanitize", "./cmd/sanitize/"
  end

  test do
    assert_match "sanitize", shell_output("#{bin}/sanitize --version")
    output = pipe_output("#{bin}/sanitize oed -q", "organise the center")
    assert_equal "organize the centre", output.strip
  end
end
