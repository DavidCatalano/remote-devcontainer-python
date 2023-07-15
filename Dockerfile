# Base image
FROM python:latest

# Set ARG values from docker-compose
ARG DEV_ENV
ARG DEV_NAME
ARG DEV_HOST
ARG CONTAINER_NAME

# Assign ARGs to ENV vars so they can be used at runtime
ENV DEV_ENV=${DEV_ENV}
ENV DEV_NAME=${DEV_NAME}
ENV DEV_HOST=${DEV_HOST}
ENV CONTAINER_NAME=${CONTAINER_NAME}

# Install Git
RUN apt-get update && \
    apt-get install -y git

# Install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# Install pipx
RUN pip install --no-cache-dir --upgrade pipx

# Copy the script and dev requirements file, then run the script
COPY requirements-dev.txt .
COPY install_dev_packages.sh .
# RUN chmod +x install_dev_packages.sh && \
#     if [ "${DEV_ENV}" = "1" ] ; then sh install_dev_packages.sh ; fi
RUN chmod +x install_dev_packages.sh && sh install_dev_packages.sh



# Set working directory
WORKDIR /app

# Keep container alive
ENTRYPOINT ["tail", "-f", "/dev/null"]
