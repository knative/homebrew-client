# Generated through hack/update-codegen.sh. Don't edit manually.
# Next line is used to identify version of the file.
# kn_version:1.15.0
require "fileutils"

class KnAT115 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.15.0"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "d46ed86454c4197874d3d210fbf2dde11cd73ab91fc3dff51942b70ecec043fe"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "941bd29dfa8d4cde07094cb5e1a4d768db1becabbff4683eed76acb1b47bc883"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "292b4e03b86d43c61ca9ba80e9277f4391c7b9ee1b86a0cedcff35518ad668ef"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "aa01d47d33b05d0e0b4705d3112fcfd95cbe06ca9d2ca3a38a85da67f60face7"
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
