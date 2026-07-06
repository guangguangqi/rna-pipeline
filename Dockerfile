FROM mambaorg/micromamba:1.5.8 as base

USER root
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Cache tools layer
COPY envs/bioinformatics.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

WORKDIR /pipeline
COPY . .

ENTRYPOINT ["/usr/local/bin/_entrypoint.sh"]

