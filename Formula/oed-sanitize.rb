class OedSanitize < Formula
  desc "Fast CLI tool for converting English text to Oxford (OED) spelling"
  homepage "https://github.com/tigger04/oed-sanitize"
  url "https://github.com/tigger04/oed-sanitize/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "b58f9e5877117a1e72f9e73d693ea8352fbcc9b939e40146efd059b51889a967"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-X main.version=0.6.0", "-o", bin/"sanitize", "./cmd/sanitize/"
  end

  test do
    assert_match "sanitize", shell_output("#{bin}/sanitize --version")
    output = pipe_output("#{bin}/sanitize oed -q", "organise the center")
    assert_equal "organize the centre", output.strip
  end
end
