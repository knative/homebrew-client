require "fileutils"

class KnAT024 < Formula
  homepage "https://github.com/knative/client"

  v = "v0.24.0"
  version v

  if OS.mac?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "831f6716dbda83aeb1e47cce4277f78c91ec50d324772d888522b8c993b317df"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "2c99586d3a84a7400fff9962711596cd7bd0365bd47a5bfd93c8b84746722f6b"
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
