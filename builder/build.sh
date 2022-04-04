pack builder create cnbs-wildfly-demo-builder:ubi --config ./builder.toml
pack config default-builder cnbs-wildfly-demo-builder:ubi
pack config trusted-builders add cnbs-wildfly-demo-builder:ubi

# optional
podman tag cnbs-wildfly-demo-builder quay.io/tborgato/cnbs-wildfly-demo-builder:ubi
podman push quay.io/tborgato/cnbs-wildfly-demo-builder:ubi


#pack builder create quay.io/tborgato/cnbs-wildfly-demo-builder:ubi --config ./builder.toml --publish