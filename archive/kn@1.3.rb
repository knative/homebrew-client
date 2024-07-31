require "fileutils"

class KnAT13 < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v1.3.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "220192fb9e73066235e2cfe3fa9b69590306453984e12c3bb610a96ef2d8a86a"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "0d63ec7cc8b4cc534a3c015c2bc11c5973a6e05c49af66f373af70669d5afac0"
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
