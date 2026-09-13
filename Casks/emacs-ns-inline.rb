cask "emacs-ns-inline" do
  version "31.1"
  sha256 "fbd475b632c5d5965c2aa2d3b4e42b85028108f273db44fb6a436361941724c5"

  url "https://pxaka.tokyo/emacs/pkg/emacs-#{version}_apple_nc.pkg"
  name "Emacs"
  desc "GNU Emacs with the ns-inline patch and native compilation"
  homepage "https://github.com/takaxp/ns-inline-patch"

  livecheck do
    url "https://raw.githubusercontent.com/takaxp/ns-inline-patch/master/README.org"
    regex(/emacs[._-]v?(\d+(?:\.\d+)+)_apple_nc\.pkg/i)
  end

  conflicts_with cask: [
    "emacs-app",
    "emacs-app@nightly",
    "emacs-app@pretest",
  ]
  depends_on arch: :arm64
  depends_on macos: :tahoe

  pkg "emacs-#{version}_apple_nc.pkg"
  # Relocating Emacs.app to /Applications would desync the pkgutil receipt, so reference it in place.
  # Contents/MacOS/Emacs is omitted: it derives its resource root from argv[0] and breaks when symlinked.
  binary "/Applications/Emacs-takaxp/Emacs.app/Contents/MacOS/bin/ebrowse"
  binary "/Applications/Emacs-takaxp/Emacs.app/Contents/MacOS/bin/emacsclient"
  binary "/Applications/Emacs-takaxp/Emacs.app/Contents/MacOS/bin/etags"
  manpage "/Applications/Emacs-takaxp/Emacs.app/Contents/Resources/man/man1/ebrowse.1.gz"
  manpage "/Applications/Emacs-takaxp/Emacs.app/Contents/Resources/man/man1/emacs.1.gz"
  manpage "/Applications/Emacs-takaxp/Emacs.app/Contents/Resources/man/man1/emacsclient.1.gz"
  manpage "/Applications/Emacs-takaxp/Emacs.app/Contents/Resources/man/man1/etags.1.gz"

  uninstall pkgutil: "com.takaxp.emacs"

  zap trash: [
    "~/Library/Caches/org.gnu.Emacs",
    "~/Library/Preferences/org.gnu.Emacs.plist",
    "~/Library/Saved Application State/org.gnu.Emacs.savedState",
  ]
end
