if OS.mac?
  require "FileUtils"
else
  require "fileutils"
end

class Kn < Formula
  homepage "https://github.com/knative/client"

  v = "v0.19.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "576af4e5c18cdbe7a9ebce62617f23f692b589500a09d57e8ea01590ebb0a836"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "7a8940e2633e53eb587d11d25762100970b1c35c52671f8ba44688c23ec190d5"
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
