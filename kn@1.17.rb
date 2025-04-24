# Generated through hack/update-codegen.sh. Don't edit manually.
# Next line is used to identify version of the file.
# kn_version:1.17.0
require "fileutils"

class KnAT117 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.17.0"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "8926f6a58a1fb4aeca4cf4edc2a288fdcfabfe1cca3fcc5193e9aa82cb6058be"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "526b79786a4a99179474e1e20150ba956d7aba054f065c2b14ef6ca4ef43a6d8"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "51be6a84959a7eafcd57b8af9ce0831e32b7d730e6338f2ef16a189bd4d1403c"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "e9c1dc399e2f5feddd6220a3a7a5c1537f709508ea99799a07d565a5ac08268f"
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
