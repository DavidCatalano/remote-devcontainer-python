include .env
export

.PHONY: build up down shell logs format lint test clean prepare-remote-folder start-sync stop-sync status-sync connect disconnect

# Build the Docker image
build:
	docker build -t $(IMAGE_NAME) .

# Start the container and enable Mutagen sync
up: start-sync
	docker-compose up -d

# Stop the container and Mutagen sync
down: stop-sync
	docker-compose down

# Open an interactive shell inside the running container
shell:
	docker exec -it $(CONTAINER_NAME) bash

# View container logs
logs:
	docker logs -f $(CONTAINER_NAME)

# Run Black & Ruff formatting inside the container
format:
	docker exec -it $(CONTAINER_NAME) black . && docker exec -it $(CONTAINER_NAME) ruff --fix .

# Run Ruff linting inside the container
lint:
	docker exec -it $(CONTAINER_NAME) ruff check .

# Run tests inside the container
test:
	docker exec -it $(CONTAINER_NAME) pytest

# Clean up all stopped containers, dangling images, and unused volumes
clean:
	docker system prune -af

# Ensure the remote project directory exists with the correct permissions
prepare-remote-folder:
	ssh $(REMOTE_HOST) "bash -c '\
		if [ ! -d \"$(REMOTE_PROJECT_PATH)\" ]; then \
			sudo mkdir -p $(REMOTE_PROJECT_PATH) && sudo chown $(APP_UID):$(APP_GID) $(REMOTE_PROJECT_PATH); \
		else \
			echo \"$(REMOTE_PROJECT_PATH) already exists. Skipping creation.\"; \
		fi'"

# Start Mutagen sync (only if no session exists)
start-sync:
	@if mutagen sync list | grep -q "$(CONTAINER_NAME)"; then \
		echo "Mutagen sync already running for $(CONTAINER_NAME)"; \
	else \
		mutagen sync create --sync-mode=two-way-resolved --ignore-vcs --name=$(CONTAINER_NAME) $(LOCAL_PROJECT_PATH) $(REMOTE_HOST):$(REMOTE_PROJECT_PATH); \
	fi

# Stop Mutagen sync for this project only
stop-sync:
	mutagen sync terminate $(CONTAINER_NAME)

# Check Mutagen sync status
status-sync:
	mutagen sync list


# Start the container with the mounted workspace
connect: prepare-remote-folder start-sync
	docker-compose up -d

# Disconnect by stopping the container and stopping sync
disconnect: stop-sync
	docker-compose down
