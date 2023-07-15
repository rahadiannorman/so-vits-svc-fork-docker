FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

LABEL org.opencontainers.image.authors "https://github.com/Hazmi35 & https://github.com/rahadiannorman"

# Ubuntu 22.04 python3 is python3.10, no need for any PPA.
RUN apt-get update \
    && apt-get install --no-install-recommends -y python3 python3-pip build-essential nano htop zip unzip \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && pip install -U torch torchaudio --index-url https://download.pytorch.org/whl/cu118 \
    && pip install -U so-vits-svc-fork
