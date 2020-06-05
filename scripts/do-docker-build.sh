#!/bin/bash -l

# Run either the pre-submit, the post-submit, or the release.
# You do not need to set up any environment, as a docker container will execute it.

# Explicitly bound environment variables
MAVEN_USER="${MAVEN_USER}"
MAVEN_PASSWORD="${MAVEN_PASSWORD}"
AZURE_USER="${AZURE_USER}"
AZURE_PASSWORD="${AZURE_PASSWORD}"
SLACK_WEBHOOK="${SLACK_WEBHOOK}"

set -Eeuo pipefail

# Go at the root of the mochi directory
cd "$(dirname "$0")/.."

print_usage_and_exit() {
  echo "Usage: $0 (pre-submit|post-submit|release COMMIT_SHA1)"
  exit 1
}

case "$1" in
  "pre-submit")
    SCRIPT="./scripts/do-pre-submit.sh"
    ;;
  "post-submit")
    SCRIPT="./scripts/do-post-submit.sh"
    ;;
  "release")
    SCRIPT="./scripts/do-release.sh"
    [ "$#" == "2" ] || print_usage_and_exit
    ;;
  *)
    print_usage_and_exit
    ;;
esac

shift # $1 is consumed

DOCKER_IMAGE="criteo-android-mopub-mediation"
SRC="$(pwd)"
DST="/android-mopub-mediation"

# Workaround for Windows. See: https://github.com/docker/toolbox/issues/673
export MSYS_NO_PATHCONV=1

echo "Building docker image"
docker build \
    --build-arg UID="$(id -u)" \
    --build-arg GID="$(id -g)" \
    -t "${DOCKER_IMAGE}" \
    .

echo "Running post-submit in docker container"
docker run \
    --rm \
    -v "${SRC}:${DST}" \
    -w "${DST}" \
    -e "MAVEN_USER=${MAVEN_USER}" \
    -e "MAVEN_PASSWORD=${MAVEN_PASSWORD}" \
    -e "AZURE_USER=${AZURE_USER}" \
    -e "AZURE_PASSWORD=${AZURE_PASSWORD}" \
    -e "SLACK_WEBHOOK=${SLACK_WEBHOOK}" \
    ${DOCKER_IMAGE} \
    bash "$SCRIPT" "$@"