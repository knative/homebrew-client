if OS.mac?
  require "FileUtils"
else
  require "fileutils"
end

class KnAT016 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.16.1"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "5696310afa3b1797cde32e773f3c34d529f0971adcd5362ebdf1517e09b1ca98"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "5e27f041c7cb3b9796b47030c77cb08538bdc8f5db4babf7bbab2f59acf9fac6"
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
