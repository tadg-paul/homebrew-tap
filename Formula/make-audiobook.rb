# ABOUTME: Homebrew formula for make-audiobook CLI tools.
# ABOUTME: Copy this file to tigger04/homebrew-tap/Formula/ after tagging a release.

class MakeAudiobook < Formula
  desc "Convert documents to audiobooks using Piper or Kokoro TTS (CLI)"
  homepage "https://github.com/tigger04/make-audiobook"
  url "https://github.com/tigger04/make-audiobook/archive/refs/tags/v3.4.0.tar.gz"
  sha256 "ee64de6ce6cbe31b84a702e50e3589af7c57ea7c02100feeb1215871c49fe056"
  license "MIT"
  head "https://github.com/tigger04/make-audiobook.git", branch: "master"

  depends_on "bash" => "5.0"
  # Note: calibre is needed for .mobi support but must be installed separately as a cask:
  # brew install --cask calibre
  depends_on "espeak" => :optional      # for Kokoro TTS engine
  depends_on "ffmpeg"
  depends_on "pandoc"
  depends_on "fzf"
  depends_on "fd"
  depends_on "pipx"

  def install
    bin.install "install-dependencies"

    # Install shell helper scripts
    if (buildpath/"shell-and-scripting-helpers").exist?
      (libexec/"shell-and-scripting-helpers").install Dir["shell-and-scripting-helpers/*"]
    end

    # Install scripts to libexec first
    libexec.install "make-audiobook" => "make-audiobook.real"
    libexec.install "piper-voices-setup" => "piper-voices-setup.real"

    # Create wrapper for make-audiobook that sources helpers from correct location
    (bin/"make-audiobook").write <<~EOS
      #!/usr/bin/env bash
      export SHELL_HELPERS_PATH="#{libexec}/shell-and-scripting-helpers"
      source "#{libexec}/shell-and-scripting-helpers/.qfuncs.sh"
      source "#{libexec}/shell-and-scripting-helpers/.colours.sh"
      exec "#{libexec}/make-audiobook.real" "$@"
    EOS

    # Create wrapper for piper-voices-setup that sources helpers from correct location
    (bin/"piper-voices-setup").write <<~EOS
      #!/usr/bin/env bash
      source "#{libexec}/shell-and-scripting-helpers/.qfuncs.sh"
      exec "#{libexec}/piper-voices-setup.real" "$@"
    EOS

    # Make the wrappers executable
    chmod 0755, bin/"make-audiobook"
    chmod 0755, bin/"piper-voices-setup"
  end

  def post_install
    ohai "To install piper-tts, run: pipx install piper-tts"
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
