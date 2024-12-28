
# Docker Management Script

This script provides a comprehensive set of functions to manage Docker containers, images, volumes, networks, and more. It offers a simple command-line menu interface to interact with Docker, making it easier to perform common Docker operations.

## Features

- **Run a New Container**: Launch a new Docker container from an image.
- **Manage Containers**: List, stop, start, and remove containers.
- **Manage Images**: List, pull, and remove Docker images.
- **Manage Volumes**: List, create, and remove Docker volumes.
- **Manage Networks**: List, create, and remove Docker networks.
- **System Cleanup**: Clean up unused Docker resources.
- **View Logs**: Display logs from a specific container.
- **View Stats**: Show live resource usage statistics of running containers.
- **File Operations**: Copy files to and from Docker containers.
- **Create Dockerfile**: Generate a basic Dockerfile in a specified directory.
- **Docker Compose Operations**: Create, run, and manage Docker Compose services.

## Prerequisites

- Docker must be installed on your system.
- Ensure you have the necessary permissions to run Docker commands.

## Usage

1. Clone this repository to your local machine:
   ```bash
   git clone <your-repo-url>
   cd <repo-directory>

Make the script executable:

chmod +x docker_management.sh

Run the script:

./docker_management.sh

Menu Options
Run a New Container: Prompts for image name and container name to run a new container.

Manage Existing Containers:

1]List containers

Stop a container

Start a container

Remove a container

2]Manage Images:

List Docker images

Pull a new image from Docker Hub

Remove an existing image

3]Manage Volumes:

List Docker volumes

Create a new volume

Remove an existing volume

4]Manage Networks:

List Docker networks

Create a new network

Remove an existing network

5]System Cleanup:

Remove unused containers

Remove unused images

Remove unused volumes

Remove all unused resources

6]Container Logs: Follow logs of a specific container.

7]Container Stats: Show real-time stats of running containers.

8]File Operations:

Copy a file to a container

Copy a file from a container

9]Create Dockerfile: Generate a basic Dockerfile in a specified directory.

10]Docker Compose Operations:

Create a new docker-compose.yml

Run Docker Compose services

Manage running Compose services

Exit: Exit the script.
