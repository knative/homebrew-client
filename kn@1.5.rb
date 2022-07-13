require "fileutils"

class KnAT15 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.5.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "4319b9b2a7f0faa3db97acb42a942b2346b115b3bc27b2d950bdf8b7d91311e4"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "663af0337985c7a1ea9b339cc0c865dba05bdacbcb8453fd63057e680c921f46"
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
