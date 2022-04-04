# Intro

CNB are orchestrated by some "lifecycle"; for example the "pack" cli is a "lifecycle" handler;

When you run "pack build", your source code is uploaded inside the "builder" image and:
- your source code is processed by the "buildpacks" inside the "builder" image
- the outcome of this process is copied to the "run" image to form the ypur final "app" image

Before you run "pack build" you need to:
- create the repositories for the images that we are going to create:
  ** https://quay.io/repository/tborgato/cnbs-stack-demo-base : stack's BASE image
  ** https://quay.io/repository/tborgato/cnbs-stack-demo-run : stack's RUN image
  ** https://quay.io/repository/tborgato/cnbs-stack-demo-build : stack's BUILD image
  ** https://quay.io/repository/tborgato/cnbs-wildfly-demo-builder : "builder" image (~ stack's BUILD image + buildpacks)
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

Two sample buildpacks are already in folder "buildpacks";

They were created with commnads such as the following:

```
pack buildpack new cnbs-wildfly-demo/cnbs-wildfly-demo-dummy-buildpack \
    --api 0.7 \
    --path buildpacks/cnbs-wildfly-demo-dummy-buildpack \
    --version 0.0.1 \
    --stacks cnbs.stack.wildfly-demo.ubi
pack buildpack new cnbs-wildfly-demo/cnbs-wildfly-demo-dummy-buildpack \
    --api 0.7 \
    --path buildpacks/cnbs-wildfly-demo-dummy-buildpack \
    --version 0.0.1 \
    --stacks cnbs.stack.wildfly-demo.ubi
```


# 1 - assemble the "builder" image

The "builder" image is the entity that links the stack with buildpacks: it basically is the stack's BUILD image, plus buildpacks;

```
pushd builder 
pack builder create cnbs-wildfly-demo-builder:ubi --config ./builder.toml
popd
```

# 2 - run "pack build"

```
pack build bootable-jar-demo --path ./bootable-jar-demo --builder cnbs-wildfly-demo-builder:ubi --env "JAVA_VERSION=java11"
```

```
pack build bootable-jar-demo \
    --env "JAVA_VERSION=java11" \
    --path ./bootable-jar-demo \
    --builder quay.io/tborgato/cnbs-wildfly-demo-builder:ubi \
    --buildpack buildpacks/cnbs-wildfly-demo-maven-buildpack \
    --buildpack buildpacks/cnbs-wildfly-demo-dummy-buildpack
```