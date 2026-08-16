class OedSanitize < Formula
  desc "Fast CLI tool for converting English text to Oxford (OED) spelling"
  homepage "https://github.com/tigger-developer/oed-sanitize"
  url "https://github.com/tigger-developer/oed-sanitize/archive/refs/tags/v0.13.0.tar.gz"
  sha256 "074959f54ed209ca3cb30274c1870e7fc19f667d56465892035b6924160a5ce4"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-X main.version=0.13.0", "-o", bin/"sanitize", "./cmd/sanitize/"
  end

  test do
    assert_match "sanitize", shell_output("#{bin}/sanitize --version")
    output = pipe_output("#{bin}/sanitize oed -q", "organise the center")
    assert_equal "organize the centre", output.strip
  end
end
