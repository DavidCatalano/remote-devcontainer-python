PROJECT_NAME=SyntheticData
IMAGE_NAME=$(PROJECT_NAME):latest

.PHONY: build up down shell logs format lint test clean

# Build the Docker image
build:
	docker build -t $(IMAGE_NAME) .

# Start the container in detached mode
up:
	docker-compose up

# Stop and remove the container
down:
	docker-compose down

# Open an interactive shell inside the running container
shell:
	docker exec -it $(PROJECT_NAME) bash

# View container logs
logs:
	docker logs -f $(PROJECT_NAME)

# Run Black & Ruff formatting inside the container
format:
	docker exec -it $(PROJECT_NAME) black . && docker exec -it $(PROJECT_NAME) ruff --fix .

# Run Ruff linting inside the container
lint:
	docker exec -it $(PROJECT_NAME) ruff check .

# Run tests inside the container
test:
	docker exec -it $(PROJECT_NAME) pytest

# Clean up all stopped containers, dangling images, and unused volumes
clean:
	docker system prune -af
