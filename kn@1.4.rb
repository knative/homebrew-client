require "fileutils"

class KnAT14 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.4.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "797e9996b82cbf92f95e132e69acb0a971b2b22cb5da11386db71d1987a09f29"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "85f0d5f11186efbf3659f7d02e3c9d72e0dcc12057d681bbcea1709462bc5740"
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
