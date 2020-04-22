require "FileUtils"

class KnAT013 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.13.2"
  url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
  version v
  sha256 "b4f653d80e56810666470075b413cecc07d30a76beca428e35476906d8eb366e"

  def install
    FileUtils.mv("kn-darwin-amd64", "kn")
    bin.install "kn"
  end

  test do
    system "#{bin}/kn", "version"
  end
end
