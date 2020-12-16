if OS.mac?
  require "FileUtils"
else
  require "fileutils"
end

class Kn < Formula
  homepage "https://github.com/knative/client"

  v = "v0.19.1"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "1ec3f600501cf4caf8d5e203ec967f67836c50230ded7bce4fd72193de722f5c"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "e6b5b4a556a4bec77ab70ef0c4436f66ae828a04461849c299354584f78518aa"
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
