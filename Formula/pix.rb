class Pix < Formula
  desc "Generate images from text prompts via the FAL API"
  homepage "https://github.com/tadg-paul/pix"
  url "https://github.com/tadg-paul/pix/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "d6cc6e0f19c2637998b76b6a5d6861c4961c5d1d9ef4d05020be8e8ad373281d"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", "-ldflags", "-s -w", "-o", bin/"pix", "."
  end

  test do
    assert_match "pix 0.3.0", shell_output("#{bin}/pix --version")
    assert_match "Usage: pix", shell_output("#{bin}/pix --help 2>&1")
  end
end