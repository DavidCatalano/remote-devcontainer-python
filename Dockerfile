FROM nvidia/cuda:12.6.0-devel-ubuntu22.04

# Set up non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3.11 python3.11-venv python3.11-dev python3-pip \
    git curl wget zip rsync jq vim git-lfs && \
    ln -sf /usr/bin/python3.11 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip && \
    pip install --upgrade pip uv && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set build-time arguments
ARG APP_GID=1000
ARG APP_UID=1000
ARG APP_USER=appuser
ARG APP_GROUP=appgroup
ARG TORCH_CUDA_ARCH_LIST=8.9

# Set environment variables
ENV PYTHONPATH="/app" \
    CUDA_HOME="/usr/local/cuda" \
    TORCH_CUDA_ARCH_LIST="${TORCH_CUDA_ARCH_LIST}"

# Create group and user
RUN groupadd -g ${APP_GID} ${APP_GROUP} && \
    useradd -u ${APP_UID} -g ${APP_GROUP} -m ${APP_USER}

# Set a friendly bash prompt
RUN echo "export PS1='\u@\h:\w\$ '" >> /home/${APP_USER}/.bashrc

# Switch to non-root user
USER ${APP_USER}:${APP_GROUP}

# Set up working directory
WORKDIR /app
