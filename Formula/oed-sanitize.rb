class OedSanitize < Formula
  desc "Fast CLI tool for converting English text to Oxford (OED) spelling"
  homepage "https://github.com/tigger04/oed-sanitize"
  url "https://github.com/tigger04/oed-sanitize/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "53e339ac5d3e272a5a6dd59b0db65b453be89cafeda6cc4971df8e2948220f42"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-X main.version=0.8.0", "-o", bin/"sanitize", "./cmd/sanitize/"
  end

  test do
    assert_match "sanitize", shell_output("#{bin}/sanitize --version")
    output = pipe_output("#{bin}/sanitize oed -q", "organise the center")
    assert_equal "organize the centre", output.strip
  end
end
