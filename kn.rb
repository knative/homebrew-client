if OS.mac?
  require "FileUtils"
else
  require "fileutils"
end

class Kn < Formula
  homepage "https://github.com/knative/client"

  v = "v0.17.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "7b93fd3383427721eff56c71ed09a20996bc0a6a1b0a28106dfbe30e67cfa765"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "e356b4cc4c1d8a44ba3cb5a877065898968ffb5f6f8d2111ce7b50657c56060b"
  end

  def install
    if OS.mac?
      FileUtils.mv("kn-darwin-amd64", "kn")
    else
      FileUtils.mv("kn-linux-amd64", "kn")
    end
    bin.install "kn"
  end

  test do
    system "#{bin}/kn", "version"
  end
end
