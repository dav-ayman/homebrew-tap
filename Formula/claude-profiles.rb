class ClaudeProfiles < Formula
  desc "Run separate Claude Desktop and Claude Code profiles side by side on macOS"
  homepage "https://github.com/dav-ayman/claude-profiles"
  url "https://github.com/dav-ayman/claude-profiles/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "c92f82cc2eb1ba3e9894db287487bdd1e8d60b9e47ef1f279914e6d1a263b856"
  license "MIT"

  depends_on :macos

  def install
    bin.install "bin/claude-profiles"
    pkgshare.install "lib/icon.js"
  end

  def caveats
    <<~EOS
      Get started:
        claude-profiles add work --default   # your current Claude becomes "Claude Work"
        claude-profiles add personal         # a second, separate profile

      Profile commands (claude-<name>) go to ~/.local/bin; make sure it is on your PATH.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/claude-profiles version")
    ENV["XDG_CONFIG_HOME"] = testpath/"config"
    ENV["CLAUDE_PROFILES_BIN_DIR"] = testpath/"bin"
    system bin/"claude-profiles", "add", "brewtest", "--no-desktop"
    assert_predicate testpath/"bin/claude-brewtest", :executable?
    assert_match "brewtest", shell_output("#{bin}/claude-profiles list")
  end
end
