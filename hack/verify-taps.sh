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

# List all *.rb files and try to install them as local Homebrew Tap formula
function verify_install() {

  pushd "${REPO_ROOT_DIR}"
  local failed=()

  for filename in *.rb; do
      local name
      name=$(echo "${filename}" | cut -d '.' -f1 | cut -d '@' -f1)

      echo "Installing from: ${filename}"

      brew install -v --formula ./"${filename}" --force || echo "Failed: ${filename}"

      if ! command -v kn >/dev/null; then
          echo "Binary $name from $filename not found. Installation probably failed."
          failed+=("${filename}")
      else
        echo "Successfully verified: ${name}"
        # Print version for logging and debugging
        kn version
      fi

      # Remove to not clash with other version, continue
      brew remove -v --formula "${filename}" --force || echo "Failed uninstall: ${filename}"
  done

  if (( ${#failed[@]} > 0 )); then
    echo "#####"
    echo "Test failed!"
    echo "Files: ${failed[*]}"
    echo "#####"
    exit 1
  fi

  popd
  echo "Test success!"
}

# Adding main for convenience. It might be useful if we have more tests.
function main() {
  verify_install
}

main "$@"
