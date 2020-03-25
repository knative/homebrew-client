require "FileUtils"

class Kn < Formula
  homepage "https://github.com/knative/client"

  v = "v0.13.1" # CI Managed
  url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
  version v
  sha256 "48587426bc0e0ad3664f69eb8688b1792366fdd23d16dfcc0a5fe8f21e4a2ba5" # CI Managed

  def install
    FileUtils.mv("kn-darwin-amd64", "kn")
    bin.install "kn"
  end

  test do
    system "#{bin}/kn", "version"
  end
end
