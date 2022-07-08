# Containerfile

ARG BASE_REGISTRY=docker.io/library
ARG BASE_IMAGE=alpine
ARG BASE_IMAGE_TAG=3.16.0

#==============================================================================#
# Image with curl and jq
#==============================================================================#
FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_IMAGE_TAG} AS base

RUN apk add --update-cache \
    curl \
    jq \
    bash && \
    rm -rf /var/cache/apk/*

WORKDIR /usr/local/bin

COPY ./regharvest ./regharvest

# Create a non-root user
RUN addgroup regharvest && \
    adduser regharvest -G regharvest --no-create-home --disabled-password
USER regharvest

ENTRYPOINT ["./regharvest"]