require "fileutils"

class KnAT110 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.10.0"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "8b128e9c64942c1f732db114b3a8575cccec5b3916f9df0ec0c7b6b3c0b898f6"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "f4a65baafc68204fed510403160306ab3f6d2ac069c09505cf41e7a3b515036a"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "cd8bd526daee40eb2d2622cc9c86f1b10f973fdd1c8c741831ecc29fd1335a4c"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "fc45d60e7567095bde670f604e11396398ab339d3a4a9107c8ad861c94db525d"
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
