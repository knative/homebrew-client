# Generated through hack/update-codegen.sh. Don't edit manually.
# Next line is used to identify version of the file.
# kn_version:1.14.0
require "fileutils"

class KnAT114 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.14.0"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "2f914e9900055b6b3300ade375699ed4c064ea38e840faf7c37785dc17fbe3be"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "8da5bcde9de0069b1e08159496008a76349fd2ceb6d455c754458c30b7852f8a"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "8ba679c4b5e2dc30e1000657216509266c549bfe5643142071806d00b9d04799"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "df33d4ed1323bfa20e84e046c13e0717e6e2a162e8a3c1b170d51d3b1d088b1c"
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
