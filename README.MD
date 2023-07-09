# Development on Remote Containers 
A remote devlopment container for VS Code preconfigured for Python. This was created to provide access to a more powerful GPU and expanded storage from a desktop PC.

### Why: Devcontainers for remote hosts
You might be here because you are trying to use devcontainers on remote hosts. Docker does not allow local folder binding to containers on remote hosts so an alternative approach is needed. The Dev Containers extension has the ability to [attach to remote containers](https://code.visualstudio.com/docs/devcontainers/attach-container). This uses a subset of the devcontainer.json spec. This repo illustrates this specifically for Python development. However, it could be modified for other scenarios.

###### Continue at [INSTALL.md](INSTALL.md) 
