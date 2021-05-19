require "fileutils"

class KnAT022 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.22.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "de91d4dc210ac6d3dadb3a5ffaebb2585cbb7241578596e675f1650dc09d6836"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "3f4131a616acc816a6548c3ae4bf5cf2ed41b36ffe9cb6c748a31b2b700ad009"
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
