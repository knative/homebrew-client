require "fileutils"

class KnAT111 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.11.0"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "c9b95d1a9ee067fb0159986efa8e99a5a7f44a39fc1a011a5ee6f6186e15cff8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "14fed921e322049edcc8700fed030044973047d123b3d7758a922f8e11cf55de"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "81a7fdb4699f403552e00466f38e58aabfbb9909aa1b00fe10a72fb9140cdd85"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "d9366d9a41563d80426df087c1fda364c37b41660d9f137e3890fd8ee7a34c71"
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
