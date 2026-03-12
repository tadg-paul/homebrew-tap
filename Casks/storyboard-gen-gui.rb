# ABOUTME: Homebrew cask for storyboard-gen GUI application.
# ABOUTME: Installs the PySide6 GUI as a standalone macOS .app bundle.

cask "storyboard-gen-gui" do
  version "0.66.0"
  sha256 "e3990e535dd6fff0f3a628ebdb025c61427dab0fb9049153ee7519c1b636db3e"

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
