#!/bin/bash -l

# Run this script to assemble and publish artifacts to Criteo nexus.
# You do not need to set up any environment, as a docker container will execute it.

set -Eeuo pipefail

# Go at the root of the project directory
cd "$(dirname "$0")/.."

./scripts/do-docker-build.sh post-submit
