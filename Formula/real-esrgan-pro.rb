class RealEsrganPro < Formula
  desc "AI image and video upscaler — CLI wrapper around Real-ESRGAN"
  homepage "https://github.com/tigger04/Real-ESRGAN"
  url "https://github.com/tigger04/Real-ESRGAN/archive/refs/tags/v--dry-run.tar.gz"
  sha256 "e0ea70866a96babcac94b03a8557b09522273e9971c22ecdfe0716996c857b72"
  license "BSD-3-Clause"
  version "--dry-run"

  depends_on "python@3.12"
  depends_on "ffmpeg"

  def install
    venv = libexec/"venv"
    system "python3.12", "-m", "venv", venv
    venv_pip = venv/"bin/pip"
    system venv_pip, "install", "--upgrade", "pip"
    system venv_pip, "install", buildpath

    (bin/"upscale").write <<~EOS
      #!/bin/bash
      exec "#{venv}/bin/upscale" "$@"
    EOS

    (bin/"upscale-video").write <<~EOS
      #!/bin/bash
      exec "#{venv}/bin/upscale-video" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Usage:
        upscale -i input.jpg -o output/
        upscale-video -i input.mp4 -o output/

      Models are downloaded automatically on first use to:
        ~/.cache/realesrgan/weights/

      Override with: export REALESRGAN_WEIGHTS_DIR=/path/to/weights

      On Apple Silicon (no CUDA), you may need --fp32 for some models.
    EOS
  end

  test do
    assert_match "usage", shell_output("#{bin}/upscale --help").downcase
    assert_match "0.3.0", shell_output("#{bin}/upscale --version")
  end
end
