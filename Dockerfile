FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

LABEL org.opencontainers.image.authors "https://github.com/Hazmi35 & https://github.com/rahadiannorman"

# Ubuntu 22.04 python3 is python3.10, no need for any PPA.
# TODO: Use multi-stage build for smaller image size, install build-essential, python3-dev for wheel on build stage only
RUN apt-get update \
    && apt-get install --no-install-recommends -y python3 python3-dev python3-pip build-essential nano htop p7zip-full \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

# Works for caching
ADD https://api.github.com/repos/voicepaw/so-vits-svc-fork/releases/latest /tmp/latest-release
RUN pip install -U torch torchaudio --index-url https://download.pytorch.org/whl/cu118 \
    && pip install -U so-vits-svc-fork
