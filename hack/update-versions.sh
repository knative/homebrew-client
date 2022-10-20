#! /usr/bin/env bash

# Copyright 2022 The Knative Authors
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

set -e

if [ -z "$CURRENT_RELEASE" ]; then
    echo 'Please provide a value for $CURRENT_RELEASE'
    exit 1
fi

if [ -z "$PREVIOUS_RELEASE" ]; then
    echo 'Please provide a value for $PREVIOUS_RELEASE'
    exit 1
fi

if [ ${CURRENT_RELEASE} = ${PREVIOUS_RELEASE} ]; then
    echo 'Nothing to do.'
    exit 0
fi

IFS='.'
read -ra newversion <<< "$CURRENT_RELEASE"
read -ra oldversion <<< "$PREVIOUS_RELEASE"
unset IFS

# validate
if [ -z ${newversion[0]} ] || [ -z ${newversion[1]} ] || [ -z ${newversion[2]} ]; then
    echo 'Please enter a valid value for $CURRENT_RELEASE in the form: x.y.z'
    exit 1
fi

if [ -z ${oldversion[0]} ] || [ -z ${oldversion[1]} ] || [ -z ${oldversion[2]} ]; then
    echo 'Please enter a valid value for $PREVIOUS_RELEASE in the form: x.y.z'
    exit 1
fi 

NEW_SHORT="${newversion[0]}.${newversion[1]}"
NEW_PATCH="${newversion[2]}"
OLD_SHORT="${oldversion[0]}.${oldversion[1]}"
OLD_PATCH="${oldversion[2]}"

echo "Updating kn from $PREVIOUS_RELEASE to $CURRENT_RELEASE"
newfile="kn.rb"
oldfile="kn@${OLD_SHORT}.rb"

# if patch release update, then we just need to update the existing kn.rb file
if [ $NEW_SHORT != $OLD_SHORT ]; then
    echo "Create formula for previous release"
    cp "$newfile" "$oldfile"
    class_version=${OLD_SHORT//.}
    class_name="Kn"
    # Flag for backup file with empty value `-i '' is added due to compatibility issue 
    # between BSD and GNU sed versions.
    # https://unix.stackexchange.com/questions/401905/bsd-sed-vs-gnu-sed-and-i 
    sed -i.bak -e "s/class ${class_name} < Formula/class ${class_name}AT${class_version} < Formula/" "$oldfile"
    echo "$oldfile created"
fi

echo "Creating formula for current release"
sed -i.bak -e "s/v${PREVIOUS_RELEASE}/v${CURRENT_RELEASE}/" "$newfile"

# change shas for mac and linux
checksums=$(mktemp)
old_checksums=$(mktemp)
curl -fsSL "https://github.com/knative/client/releases/download/knative-v${CURRENT_RELEASE}/checksums.txt" > "$checksums"
curl -fsSL "https://github.com/knative/client/releases/download/knative-v${PREVIOUS_RELEASE}/checksums.txt" > "$old_checksums"
darwin_amd64_checksum=$(awk '$2=="kn-darwin-amd64"{print $1}' "$checksums")
darwin_arm64_checksum=$(awk '$2=="kn-darwin-arm64"{print $1}' "$checksums")
darwin_amd64_old_checksum=$(awk '$2=="kn-darwin-amd64"{print $1}' "$old_checksums")
darwin_arm64_old_checksum=$(awk '$2=="kn-darwin-arm64"{print $1}' "$old_checksums")
sed -i.bak -e 's/sha256 "'"$darwin_amd64_old_checksum"'"/sha256 "'"$darwin_amd64_checksum"'"/' "$newfile"
sed -i.bak -e 's/sha256 "'"$darwin_arm64_old_checksum"'"/sha256 "'"$darwin_arm64_checksum"'"/' "$newfile"
linux_amd64_checksum=$(awk '$2=="kn-linux-amd64"{print $1}' "$checksums")
linux_arm64_checksum=$(awk '$2=="kn-linux-arm64"{print $1}' "$checksums")
linux_amd64_old_checksum=$(awk '$2=="kn-linux-amd64"{print $1}' "$old_checksums")
linux_arm64_old_checksum=$(awk '$2=="kn-linux-arm64"{print $1}' "$old_checksums")
sed -i.bak -e 's/sha256 "'"$linux_amd64_old_checksum"'"/sha256 "'"$linux_amd64_checksum"'"/' "$newfile"
sed -i.bak -e 's/sha256 "'"$linux_arm64_old_checksum"'"/sha256 "'"$linux_arm64_checksum"'"/' "$newfile"

# Remove sed backup files
rm *.bak

echo "$newfile created"

echo "Have a nice day!"
