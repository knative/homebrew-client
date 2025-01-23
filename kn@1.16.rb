# Generated through hack/update-codegen.sh. Don't edit manually.
# Next line is used to identify version of the file.
# kn_version:1.16.0
require "fileutils"

class KnAT116 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.16.0"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "5ce094218d753e34534caf35938f17b4ea0286d0c22413d2073c23990a97bd76"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "c0c197be4c3ac274b79b9566db8c07af6ddbeb68d7a3134f9d2656c7fe9e628a"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "05498ba5e1acfa392dc29643ec184e062ae30b075c80e93a29fb2399510c5c07"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "193389e757c56abcff0d3482a39f205f8ff92757458cdf11e865cbf7b2d02e67"
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
