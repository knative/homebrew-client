require "fileutils"

class KnAT17 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.7.0"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "6b0a9d3d6c3f6bf884195e9e0eb503d252c172440ab4edf4cfe6a7287ae0fad7"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "c67ff7a6188e7a418ba95784378ee8a5f2b907674b3ffaea6445a1cb8031cb1f"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "17fdb732f217edad202669fb67e7237d58f576363a57cb493c230efde9263c4f"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "6ea68983557359e0845827194299196b1c8967132eeea5b98d0f3651f9d09a9b"
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
