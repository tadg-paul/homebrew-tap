class Pix < Formula
  desc "Generate images from text prompts via the FAL API"
  homepage "https://github.com/tadg-paul/pix"
  url "https://github.com/tadg-paul/pix/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "a30ddd8dc8cc24378d94e589dc69795bbef456436908d681e8d1cc2f14fe01ce"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", "-ldflags", "-s -w -X main.version=0.4.0", "-o", bin/"pix", "."
  end

  test do
    assert_match "pix 0.4.0", shell_output("#{bin}/pix --version")
    assert_match "Usage: pix", shell_output("#{bin}/pix --help 2>&1")
  end
end