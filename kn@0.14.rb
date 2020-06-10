require "FileUtils"

class KnAT014 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.14.0"
  url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
  version v
  sha256 "23ebdc0c675f13642ba54ee7d53350404eaa01a338e15741622b72f50ecce519"

  def install
    FileUtils.mv("kn-darwin-amd64", "kn")
    bin.install "kn"
  end

  test do
    system "#{bin}/kn", "version"
  end
end
