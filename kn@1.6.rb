require "fileutils"

class KnAT16 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.6.0"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "a3523ba29896f8bfa47f5bd22970a7b1839f3a9f79a60a45db1762b04b482f30"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "88f38ef23fe28b7036847c34744180da5d7b6be63caf425a6b2733fd4004f9b1"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "a50ffcbcd78cb0a2aae36c89463d8b91908120d6676a0119badde4574e923f52"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "c683911d14c05430be9dd810481dbce178193a39e59ee5e5b1c1b0aff4bcc009"
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
