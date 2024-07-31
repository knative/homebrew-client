require "fileutils"

class KnAT11 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.1.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "580005a67fda65170c60e85236fccbc6467176e694be0944f65a5ff42f216d47"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "13099d3c62615823a2414b2fd0be4b3b56f3ee1a12f221b0719054ef7dd4ef02"
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
