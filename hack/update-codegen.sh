#! /usr/bin/env bash

# Copyright 2024 The Knative Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

[[ ! -v REPO_ROOT_DIR ]] && REPO_ROOT_DIR="$(git rev-parse --show-toplevel)"
readonly REPO_ROOT_DIR

# Retrieve latest version from given Knative repository tags
# On 'main' branch the latest released version is returned
# On 'release-x.y' branch the latest patch version for 'x.y.*' is returned
# Similar to hack/library.sh get_latest_knative_yaml_source()
function get_latest_release_version() {
    local org_name="$1"
    local repo_name="$2"
    local major_minor=""
    local version
    version="$(git ls-remote --tags --ref https://github.com/"${org_name}"/"${repo_name}".git \
      | grep "${major_minor}" \
      | cut -d '-' -f2 \
      | cut -d 'v' -f2 \
      | sort -Vr \
      | head -n 1)"
    echo "${version}"
}

# Return the major version of a release.
# For example, "v0.2.1" returns "0"
# Parameters: $1 - release version label.
function major_version() {
  local release="${1//v/}"
  local tokens=(${release//\./ })
  echo "${tokens[0]}"
}

# Return the minor version of a release.
# For example, "v0.2.1" returns "2"
# Parameters: $1 - release version label.
function minor_version() {
  local tokens=(${1//\./ })
  echo "${tokens[1]}"
}

# Return the release build number of a release.
# For example, "v0.2.1" returns "1".
# Parameters: $1 - release version label.
function patch_version() {
  local tokens=(${1//\./ })
  echo "${tokens[2]}"
}

# Fetch checksum file from release and populate.
function fetch_checksums() {
  checksums=$(mktemp)
  curl -fsSL "https://github.com/knative/client/releases/download/knative-v${1}/checksums.txt" > "$checksums"

  darwin_amd64_checksum=$(awk '$2=="kn-darwin-amd64"{print $1}' "$checksums")
  darwin_arm64_checksum=$(awk '$2=="kn-darwin-arm64"{print $1}' "$checksums")
  linux_amd64_checksum=$(awk '$2=="kn-linux-amd64"{print $1}' "$checksums")
  linux_arm64_checksum=$(awk '$2=="kn-linux-arm64"{print $1}' "$checksums")

}

# Generate file based on the inlined HEREDOC template.
function generate_tap_file() {
  out=$1
  version=$2
  old_formula=${3:-""}
cat <<EOF > "$out"
# Generated through hack/update-codegen.sh. Don't edit manually.
# Next line is used to identify version of the file.
# kn_version:${version}
require "fileutils"

class Kn${old_formula} < Formula
  homepage "https://github.com/knative/client"

  v = "knative-v${version}"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-amd64"
    sha256 "${darwin_amd64_checksum}"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-darwin-arm64"
    sha256 "${darwin_arm64_checksum}"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-arm64"
    sha256 "${linux_arm64_checksum}"
  else
    url "https://github.com/knative/client/releases/download/#{v}/kn-linux-amd64"
    sha256 "${linux_amd64_checksum}"
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
EOF
}

pushd $REPO_ROOT_DIR

# The script is meant to be executed though GH action to generate content update and review in the PR.

# Get sem ver from kn.rb file, in format x.y.z
current_homebrew_version=$(cat "kn.rb" | grep "kn_version:" | cut -d ':' -f2)
# Get latest released version from knative/client git repository
latest_release_version=$(get_latest_release_version "knative" "client")

# Assume major_version is always equal '1'
if (( $(minor_version "$current_homebrew_version") == $(minor_version "$latest_release_version") )); then
  if (( $(patch_version "$current_homebrew_version") == $(patch_version "$latest_release_version") )); then
    echo "Current kn.rb in up to date with latest release: ${latest_release_version}"
    exit 0
  else
    echo "Newer patch release is available: ${latest_release_version}"
    fetch_checksums "${latest_release_version}"
    # Regenerate main kn.rb file to update patch version
    generate_tap_file "kn.rb" "${latest_release_version}"
  fi
else
  echo "Newer release is available: ${latest_release_version}"

  # Generate definition for older release first
  current_minor=$(minor_version "$current_homebrew_version")
  old_file="kn@1.${current_minor}.rb"
  fetch_checksums "${current_homebrew_version}"
  generate_tap_file "${old_file}" "${current_homebrew_version}" "AT1${current_minor}"

  # Regenerate the main kn.rb file
  fetch_checksums "${latest_release_version}"
  generate_tap_file "kn.rb" "${latest_release_version}"
fi

echo "Please, make sure to commit all generated files."

