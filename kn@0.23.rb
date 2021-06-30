require "fileutils"

class KnAT023 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.23.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "99d14d05489e46315229d59b3df39f98ff98a1420e04cab538643fd1e3c0977a"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "345d95909ec9568261297976eacef70e67ea4cb178e6ee5db012e2b4a66e32ee"
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
