if OS.mac?
  require "FileUtils"
else
  require "fileutils"
end

class KnAT017 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.17.3"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "63c8cec08d4f5d9ea4c960c063813a679ccdca73409942b18c1a427d8ccf085e"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "85e9b281837811ba8828a22aae7f51a0690ab0f1bca793a3b9ba1697500d92b8"
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
