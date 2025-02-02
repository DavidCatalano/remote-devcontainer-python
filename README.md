# Remote Docker ML Devcontainer Template

## Overview

This repository provides a **fully configured template** for setting up a **remote development environment** using Docker, Devcontainers, and **NVIDIA GPU acceleration**. It is designed for developers who:

- Work on **a remote container server** rather than a local Docker instance.
- Need a persistent environment to **run ML utilities and experiments**.
- Want a **fully isolated, portable**, and reproducible workflow for their projects.
- Require **two-way file synchronization** between their local machine and the remote container, making it feel like a local devcontainer.

This setup allows for **seamless development in VS Code**, efficient dependency management via `uv`, optimized GPU utilization for ML workloads, and **automatic file synchronization using Mutagen**.

## Key Features

✅ **Remote Devcontainer Setup** – Easily connect from VS Code using `devcontainer.json`.

✅ **NVIDIA GPU Support** – Configured for **CUDA 12.6** with flexible GPU options.

✅ **Two-Way File Sync (Mutagen)** – Keeps local and remote files in sync, making the remote container behave like a local development environment.

✅ **Preconfigured Python Environment** – Uses `uv` for fast package management.

✅ **Non-Root User Execution** – Avoids running the container as `root` for security.

✅ **Minimal Base Dependencies** – Ready for your PIP and APT packages.

## Getting Started

### 1️⃣ Prerequisites

Ensure your **remote Docker server** meets the following requirements:

- **Ubuntu 22.04** (or compatible)
- **NVIDIA GPU** with CUDA support
- **Docker & NVIDIA Container Toolkit installed**
- **VS Code with Remote - Containers extension** (for local development)
- **Passwordless SSH access**
- **Mutagen installed** on both your **local machine** and the **remote host**.

  #### Local Mutagen Install
  `brew install mutagen-io/mutagen/mutagen`
 
  #### Remote Host Mutagen Install
  ```
  wget https://github.com/mutagen-io/mutagen/releases/download/v0.18.0/mutagen_linux_amd64_v0.18.0.tar.gz
  tar -xzf mutagen_linux_amd64_v0.18.0.tar.gz
  sudo mv mutagen /usr/local/bin/
  tar -tvf mutagen-agents.tar.gz # find the proper binary
  tar -xzf mutagen-agents.tar.gz linux_amd64 # extract the proper binary
  sudo mv linux_amd64 /usr/local/bin/mutagen-agents # move and rename the agents binary
  mutagen daemon start
  ```

### 2️⃣ Clone This Repo

```sh
git clone https://github.com/DavidCatalano/remote-devcontainer-python.git
mv remote-devcontainer-python ./{YOUR_PROJECT}
cd {YOUR_PROJECT}
```

### 3️⃣ Set Up Environment Variables

Copy `.env.example` to `.env` and modify as needed:
```sh
cp .env.example .env
```
Modify values in `.env` to match your setup.

### 4️⃣ Prepare the Remote Folder
Before starting the container, you need to create and set up the remote workspace directory:
`make prepare-remote-folder`
This will:
- Create the necessary folder on the remote Docker server.
- Set the correct permissions for your user.

### 5️⃣ Build / Start / Stop the Devcontainer
**Build** the container:
```sh
make build
```

**Start** the container:
```sh
make connect
```
This will:
- Start Mutagen sync (bi-directional file sync).
- Start the Docker container on the remote server.
- Ensure all necessary dependencies are installed.

**Stop** the container:
```sh
make disconnect
```
This will:
- Stop Mutagen sync.
- Stop the Docker container on the remote server.


### 6️⃣ Open in VS Code

1. Open VS Code
2. Use **Remote-Containers: Attach to Running Container**
3. Select the container **ProjectName**


## Usage Notes

### **Two-Way File Sync (Mutagen)**

- This template uses Mutagen to keep local and remote files in sync, making the remote devcontainer behave like a local environment.
- Any file changes made locally will sync to the remote container automatically.
- Any file changes inside the container (e.g., pip install, code edits) sync back to your local machine.

### Available Makefile Commands
The Makefile provides an automated workflow:

**Container Management**
```sh
make build          # Build the Docker image
make up             # Start the container & sync files
make down           # Stop the container & stop sync
make shell          # Open an interactive shell inside the container
make logs           # View container logs
```

**Mutagen Sync Management**
```sh
make start-sync     # Start file sync (only if not already running)
make stop-sync      # Stop file sync for this project
make status-sync    # Check sync status
```

**Development Tools**
```sh
make format         # Run Black & Ruff formatting
make lint           # Run Ruff linting
make test           # Run Pytest tests
make clean          # Remove stopped containers & unused images
```

### Project Folder Mapping
- Instead of using Docker named volumes, this template maps a remote folder (`/data/workspaces/{PROJECT_NAME}`) to the container.
- The folder is persisted across container restarts.

## Contributing

Issues and suggestions are welcome via PRs.

## License

MIT License - Free to use and modify.

