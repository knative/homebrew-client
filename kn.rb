# Generated through hack/update-codegen.sh. Don't edit manually.
# Next line is used to identify version of the file.
# kn_version:1.13.0
require "fileutils"

class Kn < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.13.0"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "3406ef887cd1e27df6d3f554e044ff6b6bcf2ac7b7c3c039370355bb4f960000"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "81d4d5fa701323894815b772bc5ef44c566c76b5a124296b0c53f1ac27c2bd96"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "de1f6747559fde68ca65a31903ab5f3b0cce7365a28cf997068bbbdaf92069f7"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "289eb39dfcb1c7d9b4976db039155347e8305fe484123a2e85c2d48fba751264"
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
