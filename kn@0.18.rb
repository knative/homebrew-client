if OS.mac?
  require "FileUtils"
else
  require "fileutils"
end

class KnAT018 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.18.2"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "9f48f48fb3e39c9bd4e31fd9459ad58c605589ce55edf9e0209d88f351dff7ad"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "18e9a6ca1bf0e049ad1e35c4bb384a3136aaff0d8084cef164a6f74c89b11a4e"
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
