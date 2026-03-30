class OedSanitize < Formula
  desc "Fast CLI tool for converting English text to Oxford (OED) spelling"
  homepage "https://github.com/tigger04/oed-sanitize"
  url "https://github.com/tigger04/oed-sanitize/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "3ffe8ef902c9544855f424c8a73883fe913bcc4340bc489b831b92a012ab37a1"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-X main.version=0.5.0", "-o", bin/"sanitize", "./cmd/sanitize/"
  end

  test do
    assert_match "sanitize", shell_output("#{bin}/sanitize --version")
    output = pipe_output("#{bin}/sanitize oed -q", "organise the center")
    assert_equal "organize the centre", output.strip
  end
end
