if OS.mac?
  require "FileUtils"
else
  require "fileutils"
end

class KnAT015 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.15.2"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "c673b57a5fcc26b58b0491cff52d0de01e985d2cf87c6af5a9b730c16c7113c0"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "47b09a8b4ac9d738f0ab4ae1e78902745a49cd5721ce967d1f93b77c41f33b9e"
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
