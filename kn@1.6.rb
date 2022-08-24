require "fileutils"

class Kn < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.6.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "a3523ba29896f8bfa47f5bd22970a7b1839f3a9f79a60a45db1762b04b482f30"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "c683911d14c05430be9dd810481dbce178193a39e59ee5e5b1c1b0aff4bcc009"
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
