if OS.mac?
  require "FileUtils"
else
  require "fileutils"
end

class KnAT017 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.17.1"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "ca02c0a9cfbc95f95d3380aac913368094d6463dd2500d4be260993a1131e5de"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "221f49aec604107fd675c3a7f3384488da09501f71f2cea98b4de20b563f86d1"
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
