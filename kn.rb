if OS.mac?
  require "FileUtils"
else
  require "fileutils"
end

class Kn < Formula
  homepage "https://github.com/knative/client"

  v = "v0.18.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "138fd3cbe7a4548c031d576a4f46adcd8c4e16760d21d28a92491cc6b1714b69"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "a04789fc2f590ac141057d8f92f7bb10fb0fbb6a994bd86a4678008a3dfb1ca3"
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
