require "fileutils"

class KnAT021 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.21.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "6daa5a9f1108b71bfcd22f293494f6b4bfd6d2937f76e8f7ba48e1d969e68d31"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "f57427f523b2d882af796a87be47ffb061c2c0a0543b851af74f58ac2945f910"
  end

  def install
    if OS.mac?
      FileUtils.mv("kn-darwin-amd64", "kn")
    else
      FileUtils.mv("kn-linux-amd64", "kn")
    end
    bin.install "kn"
  end

  test do
    system "#{bin}/kn", "version"
  end
end
