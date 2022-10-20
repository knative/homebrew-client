require "fileutils"

class Kn < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.8.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "0db19ab608dfb7b0efc7c3032f5f683f79217ebd479ae4ea993893afa57090f9"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "943b096b549f2580d72b0b59a571eb0654822c7c47784345dc24d1b820bca149"
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
