if OS.mac?
  require "FileUtils"
else
  require "fileutils"
end

class KnAT017 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.17.3"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "8f7b9f2dd11f2bcabdc89c50a4b865e7822cf1e815131b35435f2335199ee0d9"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "c64fdd3d9b24ee504b8d7852dd8d1232eec94d14c2ea3dfe1f68a710a6661d84"
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
