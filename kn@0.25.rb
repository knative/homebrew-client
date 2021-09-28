require "fileutils"

class KnAT025 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.25.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "bd8a71d5598e73fd91acc49d1a8f88673dcf4b82a3be8bc0cb2f6be398bd86f2"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "0462ef813ccfa456392e7d2d527bf2c106122a8f869b1c912f65b527c3de21fc"
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
