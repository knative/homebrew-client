require "fileutils"

class KnAT19 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.9.0"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "285b1aced62762f10671935e0cc1a1e395262b25e907256b17c6a24805a6c17a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "686ce92ce5a9efdd5e92988aff32f52ea049f3954398836d14c66f990848c464"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "ec94b8bc44f4e2b617c0f257f0637ee7a0873e3b2080410fc07d256895929bc7"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "9509d977a3066ab9b4b11bbfd263acb7691491b9a6126db0bb543811c4a42514"
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
