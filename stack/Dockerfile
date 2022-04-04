# =======================================
# Base Image
# =======================================

# 1. Set a common base
FROM registry.access.redhat.com/ubi8/ubi as base

# 2. Set required CNB information
ENV CNB_USER_ID=1000
ENV CNB_GROUP_ID=1000
ENV CNB_STACK_ID="cnbs.stack.wildfly-demo.ubi"
LABEL io.buildpacks.stack.id="cnbs.stack.wildfly-demo.ubi"

# 3. Create the user
RUN groupadd cnb --gid ${CNB_GROUP_ID} && \
  useradd --uid ${CNB_USER_ID} --gid ${CNB_GROUP_ID} -m -s /bin/bash cnb

# =======================================
# Run Image
# =======================================

# 5. Start a new run stage
FROM base as run

LABEL io.buildpacks.stack.mixins: []

# 6. Set user and group (as declared in base image)
USER ${CNB_USER_ID}:${CNB_GROUP_ID}  

# =======================================
# Build Image
# =======================================

# 7. Start a new build stage
FROM base as build

LABEL io.buildpacks.stack.mixins: ["build:git", "build:wget"]

# 8. Install packages that we want to make available at build time
RUN yum install -y wget git jq && yum clean all

# 9. Set user and group (as declared in base image)
USER ${CNB_USER_ID}:${CNB_GROUP_ID}