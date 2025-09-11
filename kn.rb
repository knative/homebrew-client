# Generated through hack/update-codegen.sh. Don't edit manually.
# Next line is used to identify version of the file.
# kn_version:1.19.4
require "fileutils"

class Kn < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.19.4"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "337051b1b31f4466c0e624e7b4f15c2d2db2c426b2f5d7e7ea7e4a9bf6693dfe"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "05af0b79cb2409e01422ae8d4b7f94f8aaaec027e37884b62bfb71728fdb0806"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "970021f1c42c47a9c3bbb84d0b4ef2c87bdd84c876a35c4679e6ce65d851167f"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "7e08b067256d58968bdbe2531c1c44c40d92d174885bee549d6febbb4ff1589e"
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
