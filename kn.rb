if OS.mac?
  require "FileUtils"
else 
  require "fileutils"
end

class Kn < Formula
  homepage "https://github.com/knative/client"

  v = "v0.15.1"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "b594731a04f49c6b130245193aaf93eb53235ca01abed9b5a97fb54ef8c18577"
  else 
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "aa66d8f3c442219522bc8a135aa04b25700e2da9153b436c2d8259c6705ff88d"
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

