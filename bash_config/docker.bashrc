export DOCKER_BUILDKIT=1
export BUILDKIT_PROGRESS=plain # show stdout in build logs

# fixes auth/ssl problems with pulling base images
# https://github.com/docker/buildx/issues/1613
export BUILDKIT_NO_CLIENT_TOKEN=true
