# ABOUTME: Homebrew cask for storyboard-gen GUI application.
# ABOUTME: Installs the PySide6 GUI as a standalone macOS .app bundle.

cask "storyboard-gen-gui" do
  version "0.60.0"
  sha256 "79d7513b26774c1976ed347e96a2fd9e9e7369e234b84e8a6e9f395b3c4b9e1d"

  url "https://github.com/tigger04/storyboard-gen/releases/download/v#{version}/storyboard-gen-gui-#{version}.dmg"
  name "Storyboard Gen"
  desc "Generate video stills and clips from YAML storyboards using AI"
  homepage "https://github.com/tigger04/storyboard-gen"

  depends_on macos: ">= :monterey"

  app "Storyboard Gen.app"

  zap trash: [
    "~/Library/Preferences/com.tigger04.storyboard-gen.plist",
  ]

  caveats <<~EOS
    Storyboard Gen GUI requires ffmpeg to be installed:
      brew install ffmpeg

    At least one AI provider is required. Configure credentials in a .env
    file in your project directory (Google, FAL.ai, or Replicate).
    See: https://github.com/tigger04/storyboard-gen#quickstart

    The CLI tool is available separately:
      brew install tigger04/tap/storyboard-gen
  EOS
end
