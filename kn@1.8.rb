require "fileutils"

class KnAT18 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.8.1"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "af9c71b27d88d785e5a47a95695258f3ded9650c4ab383eb94bce0b4c98380c6"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "9dd819e536e1abf725ac32a910656df491e814b540bb3d835040807ebf74cb09"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "4ba7abac7cc147ed008eeab1a6343918cb0243c311fc51ae57a329c69c505bc0"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "bb0e52175a08dcb1ef0ee4c519959862defea1042a77f62047b3114bb55bece5"
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
