require "fileutils"

class KnAT12 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.2.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "3f8250886b3c8b584e33cebea185d5c463b0416f618b69e8be5e0273e756c6d2"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "3aba2d0bd9b3ce6133166148d1ec40f9cdc24c28f8899d1f838f8397af62cbd0"
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
