# ABOUTME: Homebrew formula for make-audiobook CLI tools.
# ABOUTME: Copy this file to tigger04/homebrew-tap/Formula/ after tagging a release.

class MakeAudiobook < Formula
  desc "Convert documents to audiobooks using Piper or Kokoro TTS (CLI)"
  homepage "https://github.com/tigger04/make-audiobook"
  url "https://github.com/tigger04/make-audiobook/archive/refs/tags/v3.7.0.tar.gz"
  sha256 "401790c4b4e957511176daf93a74baeec154aac9d79709584ce9765b90973140"
  license "MIT"
  head "https://github.com/tigger04/make-audiobook.git", branch: "master"

  depends_on "bash" => "5.0"
  # Note: calibre is needed for .mobi support but must be installed separately as a cask:
  # brew install --cask calibre
  depends_on "espeak"                    # required by Kokoro TTS engine
  depends_on "ffmpeg"
  depends_on "pandoc"
  depends_on "fzf"
  depends_on "fd"
  depends_on "pipx"
  depends_on "python@3.12"              # kokoro-tts requires Python <3.13

  def install
    bin.install "make-audiobook"
    bin.install "piper-voices-setup"
    bin.install "install-dependencies"
  end

  def post_install
    ohai "Installing piper-tts via pipx..."
    system "pipx", "install", "piper-tts"
    # kokoro-tts requires Python <3.13; find highest compatible version
    py312 = Formula["python@3.12"].opt_bin/"python3.12"
    if py312.exist?
      ohai "Installing kokoro-tts via pipx (Python 3.12)..."
      system "pipx", "install", "kokoro-tts", "--python", py312
    else
      ohai "kokoro-tts requires Python <3.13. Install python@3.12, then: pipx install kokoro-tts --python python3.12"
    end
    ohai "To install default voices, run: piper-voices-setup"
  end

  def caveats
    <<~EOS
      To install piper-tts, run:
        pipx install piper-tts

      To install default English voices, run:
        piper-voices-setup

      For .mobi file support, install calibre:
        brew install --cask calibre

      For additional voices, visit:
        https://huggingface.co/rhasspy/piper-voices

      For Kokoro TTS engine (optional, higher quality):
        brew install espeak
        pipx install kokoro-tts

      For the GUI version, install the cask instead:
        brew install --cask tigger04/tap/make-audiobook
    EOS
  end

  test do
    assert_match "usage", shell_output("#{bin}/make-audiobook --help", 0)
  end
end
