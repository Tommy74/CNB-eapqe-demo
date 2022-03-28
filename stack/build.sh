# podman run -it --rm registry.access.redhat.com/ubi8/ubi /bin/bash
# podman login quay.io

# "base" image for both "run" and "build" images
podman build . -t quay.io/tborgato/cnbs-stack-demo-base:ubi --target base
podman push quay.io/tborgato/cnbs-stack-demo-base:ubi

# "run" image
podman build . -t quay.io/tborgato/cnbs-stack-demo-run:ubi --target run
podman push quay.io/tborgato/cnbs-stack-demo-run:ubi

# "build" image
podman build . -t quay.io/tborgato/cnbs-stack-demo-build:ubi --target build
podman push quay.io/tborgato/cnbs-stack-demo-build:ubi