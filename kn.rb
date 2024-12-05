# Generated through hack/update-codegen.sh. Don't edit manually.
# Next line is used to identify version of the file.
# kn_version:1.16.1
require "fileutils"

class Kn < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.16.1"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "6cbe9fb216c4b4f90fbd4d8c516229bc7b4a8fe142dfcad02068e6d7eb894be6"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "e6ff0557abe70b7bcfb9ab13c9cca9ef3ee6e0e2a3b24d16bef8f271c6bcac1b"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "1c7a60d4d96a8d062fabfc1df019eb2f5b2cb3349838ed19aeee0bf611991bc7"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "1732efe21c546e97b8f334d70e3b19997bc6a118e26cc914c9601b1c60bacba4"
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
