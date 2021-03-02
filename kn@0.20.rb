if OS.mac?
  require "FileUtils"
else
  require "fileutils"
end

class KnAT020 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.20.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "2a55ba0539444389c24186818e5b0b9ef77113a02f2e745ff3cbb0656c98c8ec"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "3bcc486df7849799d6765f3ba41720139545127651630ddc5cc2a81cb74818d5"
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
