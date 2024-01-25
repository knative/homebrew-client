require "fileutils"

class KnAT112 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.12.0"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "8ffb052263454250d46eecba47e64be9be2b4d6ac97abab0c2c503d327693d87"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "f07d70a7c62c107dad399fadb62804979fd99f1957f421c0fc349a9dc64f5153"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "3c02f47aaba3533c92ff32a5d02e3ac845b687b4c96735d637b0e810ce8d2a7c"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "d8ec5f3beff4b9bccea7b67937370f477537d6188e178a4c36a11162d4d06cf5"
  end

  def install
    if OS.mac? && Hardware::CPU.intel?
      FileUtils.mv("kn-darwin-amd64", "kn")
    elsif OS.mac? && Hardware::CPU.arm?
      FileUtils.mv("kn-darwin-arm64", "kn")
    elsif OS.linux? && Hardware::CPU.arm?
      FileUtils.mv("kn-linux-arm64", "kn")
    else
      FileUtils.mv("kn-linux-amd64", "kn")
    end
    bin.install "kn"
  end

  test do
    system "#{bin}/kn", "version"
  end
end
