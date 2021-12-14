require "fileutils"

class KnAT10 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.0.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "7ca666b399b481fb6dd003535feeb8c9d3cf969ad50d481e9159b5770fba7844"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "47fe4465e4d802a7d03ab01fe367af2ddda23b5eb4d87b575d83a9f32ba83a34"
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
