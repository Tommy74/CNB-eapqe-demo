# Intro

CNB are orchestrated by some "lifecycle"; for example the "pack" cli is a "lifecycle" handler;

When you run "pack build", your source code is uploaded inside the "builder" image and:
- your source code is processed by the "buildpacks" inside the "builder" image
- the outcome of this process is copied to the "run" image to form the ypur final "app" image

Before you run "pack build" you need to:
- create the "base", "build" and "run" images: the so called "stack"
- code your "buildpacks"
- assemble the "builder" image: this is basically "build" + "buildpacks"

## docker socket

If you are using PODMAN, before you begin you need:
```
systemctl enable --user podman.socket
systemctl start --user podman.socket
sudo ln -f -s $(podman info -f "{{.Host.RemoteSocket.Path}}") /var/run/docker.sock
```

# create the "base", "build" and "run" images

```
pushd stack
./build.sh
popd
```

# to code your "buildpacks"

Two sample buildpacks are in folder "buildpacks"

# assemble the "builder" image

```
pushd builder 
pack builder create cnbs-eapqe-demo-builder:ubi --config ./builder.toml
popd
```

# run "pack build"

```
pack build bootable-jar-demo --path ./bootable-jar-demo --builder cnbs-eapqe-demo-builder:ubi
```

```
pack build bootable-jar-demo \
    --path ./bootable-jar-demo \
    --builder quay.io/tborgato/cnbs-eapqe-demo-builder:ubi \
    --buildpack buildpacks/cnbs-eapqe-demo-maven-buildpack \
    --buildpack buildpacks/cnbs-eapqe-demo-dummy-buildpack
```