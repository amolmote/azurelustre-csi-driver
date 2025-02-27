#!/bin/bash

# Copyright 2020 The Kubernetes Authors.
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

set -euo pipefail

ver="main"
if [[ "$#" -gt 0 ]]; then
  ver="$1"
fi

repo="https://raw.githubusercontent.com/kubernetes-sigs/azurelustre-csi-driver/$ver/deploy"

if [[ "$#" -gt 1 ]]; then
  if [[ "$2" == *"local"* ]]; then
    echo "use local deploy"
    repo="./deploy"
  fi
fi

if [ $ver != "main" ]; then
  repo="$repo/$ver"
fi

echo "Installing Azure Lustre CSI driver, version: $ver, repo: $repo ..."
kubectl apply -f $repo/rbac-csi-azurelustre-controller.yaml
kubectl apply -f $repo/rbac-csi-azurelustre-node.yaml
kubectl apply -f $repo/csi-azurelustre-driver.yaml
kubectl apply -f $repo/csi-azurelustre-controller.yaml
kubectl apply -f $repo/csi-azurelustre-node.yaml
echo 'Azure Lustre CSI driver installed successfully.'