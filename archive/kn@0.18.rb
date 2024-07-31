require "fileutils"

class KnAT018 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.18.4"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "4ad739d5211084a7eea05313c6d0c0475c78f74d16fdbb0bbfa8b1512da569f0"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "d89bdfb1ca39e191f4acf088e6a37302715cb682dd238f1928ebb578f165cbfa"
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
