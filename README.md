# Remote Docker ML Devcontainer Template

## Overview

This repository provides a **fully configured template** for setting up a **remote development environment** using Docker, Devcontainers, and **NVIDIA GPU acceleration**. It is designed for developers who:

- Work on **a remote container server** rather than a local Docker instance.
- Need a persistent environment to **run ML utilities and experiments**.
- Want a **fully isolated, portable**, and reproducible workflow for their projects.

This setup allows for **seamless development in VS Code**, efficient dependency management via `uv`, and optimized GPU utilization for ML workloads.

## Key Features

✅ **Remote Devcontainer Setup** – Easily connect from VS Code using `devcontainer.json`.

✅ **NVIDIA GPU Support** – Configured for **CUDA 12.6** with flexible GPU options.

✅ **Persistent Docker Volumes** – Source code persists across container rebuilds.

✅ **Preconfigured Python Environment** – Uses `uv` for fast package management.

✅ **Non-Root User Execution** – Avoids running the container as `root` for security.

✅ \*\*Minimal\*\* – Base dependencies can be expanded as needed.

## Getting Started

### 1️⃣ Prerequisites

Ensure your **remote Docker server** meets the following requirements:

- **Ubuntu 22.04** (or compatible)
- **NVIDIA GPU** with CUDA support
- **Docker & NVIDIA Container Toolkit installed**
- **VS Code with Remote - Containers extension** (for local development)

### 2️⃣ Clone This Repo

```sh
git clone [https://github.com/yourusername/your-repo.git](https://github.com/yourusername/your-repo.git)
cd your-repo
```

### 3️⃣ Set Up Environment Variables

Copy `.env.example` to `.env` and modify as needed:
```sh
cp .env.example .env
```
Modify values in `.env` to match your setup.

### 4️⃣ Start the Devcontainer

Run the following command to build and start the container:
```sh
docker-compose up -d --build
```

### 5️⃣ Open in VS Code

1. Open VS Code
2. Use **Remote-Containers: Attach to Running Container**
3. Select the container **ProjectName**

## Configuration Details

### **Docker & Devcontainer Setup**

This template is built with:

- `nvidia/cuda:12.6.0-devel-ubuntu22.04` as the base image
- `docker-compose.yml` for container orchestration
- A preconfigured `devcontainer.json` for VS Code integration
- Python 3.11 installed manually (as it's not included in CUDA images)

### **GPU Configuration**

By default, all available GPUs are exposed to the container:
```yaml
deploy:
resources:
reservations:
devices:
- driver: nvidia
count: all
capabilities: [gpu]
```
You can modify this in `.env` using:
```ini
NVIDIA_GPU_COUNT=all
```

### **Preinstalled Tools & Libraries**

This template comes with essential tools for development:

- **CLI Tools**: `wget`, `zip`, `rsync`, `jq`, `vim`, `git-lfs`
- **Python Tools**: `ruff`, `black`, `mypy`, `pytest`, `requests`, `pydantic`
- **CUDA Variables**:
  - `CUDA_HOME=/usr/local/cuda`
  - `TORCH_CUDA_ARCH_LIST=8.9` (can be overridden in `.env`)

## Usage Notes

### **Persistent Volumes**

- This template uses a **Docker named volume** (`ProjectName_src`) instead of a host-mounted directory.
- To reset the container **without losing source code**, just run:
  ```sh
  docker-compose down && docker-compose up -d
  ```
- To **fully wipe everything** (including source code), run:
  ```sh
  docker volume rm ProjectName\_src
  ```

## Contributing

Issues and suggestions are welcome via PRs.

## License

MIT License - Free to use and modify.

