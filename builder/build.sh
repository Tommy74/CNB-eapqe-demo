pack builder create cnbs-eapqe-demo-builder:ubi --config ./builder.toml
pack config default-builder cnbs-eapqe-demo-builder:ubi
pack config trusted-builders add cnbs-eapqe-demo-builder:ubi

# optional
podman tag cnbs-eapqe-demo-builder quay.io/tborgato/cnbs-eapqe-demo-builder:ubi
podman push quay.io/tborgato/cnbs-eapqe-demo-builder:ubi


#pack builder create quay.io/tborgato/cnbs-eapqe-demo-builder:ubi --config ./builder.toml --publish