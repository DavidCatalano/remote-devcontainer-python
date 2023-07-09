
### Prerequisites:
* Docker running on a remote computer with passwordless ssh access
* [Remote access](https://docs.docker.com/config/daemon/remote-access/) to dockerd
* Docker CLI running on local machine (Docker Desktop not required)
* Dev Container extension installed in VS Code: [ms-vscode-remote.remote-containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
* Modify paths in all shell scripts if not running macOS.
* Test remote docker permissions and configuration by running: `sh test_remote.sh`

### Setup:
1. Copy `.env.example` to `.env` and set variables for your project and remote host
1. Adjust `container_config.json` per your preferences, making sure to add any requisite development packages to `requirements-dev.txt`
1. Modify `requirements.txt` per your project or leave blank and configure later
1. Install the container_config.json file into the proper place in VS Code `sh install_container_config.sh`
1. Build the container `sh build.sh`

### Run:
1. Run: `sh run.sh` if the container is not running
1. Open VS Code command palette and select: `Dev Containers: Attach to Running Container...`
1. Select the running container

### Appendix:
* To remove the container _and_ volume for the project run: `sh wipe.sh`
* If you do not use Docker locally you can simplify command line management using an environment variable, e.g. `export DOCKER_HOST=ssh://david@devbox`. This will allow commands such as `docker ps` to use the remote host instead of the local one without using the `-H` flag.
* At times there is a race condition loading extensions preventing one to not initialize. To correct, select: `Developer: Reload Window` from the command palette.