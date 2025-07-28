# Generated through hack/update-codegen.sh. Don't edit manually.
# Next line is used to identify version of the file.
# kn_version:1.18.0
require "fileutils"

class KnAT118 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.18.0"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "8aedb15a73b0c2676f3c006db153f17fa528bd99a4fe5ffd76bab3a82f956ac6"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "9be7e4e2ad865145cfb0f2cfbc6ba4283de99f37209cd0f2566a88a2763e2ac9"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "f0e07ad56c9f814b01f35481a59eb0cd93a5c9df24b418e5dde044b924bec7a2"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "e5952304f91fdbb6532613cbab3e91e0b46be0f4bdcf0af62191de381116ca4e"
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
