# Generated through hack/update-codegen.sh. Don't edit manually.
# Next line is used to identify version of the file.
# kn_version:1.22.0
require "fileutils"

class KnAT122 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.22.0"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "87f0c7cb789b42931e87484defc29cad2feac5dd1ae3b587921059d4fbf1cb6e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "15036c4bb1d4a6b7c925f0cb1a3e1bed9b296504b023987d91f7b997a849eebf"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "3b2b50218aad812b04602e4f4e6344da3e779d6a1a0b2d8e19b77a7a4a3f7eb1"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "b01ed7b430a0346401bfbc939b72262a61d411c33aaf72f99858028ccc787bb9"
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
