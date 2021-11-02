require "fileutils"

class KnAT026 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.26.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "cfd463f4fed51ac54359d0d3e40bf37275d0b781b7910fe88e7ac7c240fb261f"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "93248e1e2b665bfb68092cc7c49fd96405c9b008688a21d920aae9bc455b538f"
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
