# docker_scripting

Explanation:
Pull a Docker image:

docker pull httpd:latest: Pulls the latest version of the nginx image from Docker Hub.

Run a Docker container:

docker run -d --name myweb1 -p 8080:80 httpd:latest: Runs the nginx container in detached mode with port 8080 on the host mapped to port 80 on the container.

Access Docker information:

docker ps: Lists all running Docker containers.

docker logs my_nginx: Shows the logs of the my_nginx container.

docker inspect my_nginx: Provides detailed information about the my_nginx container in JSON format.

docker images: Lists all Docker images present on the system.

docker info: Displays system-wide information about Docker.

docker stats --no-stream my_nginx: Shows real-time statistics (CPU, memory, etc.) for the myweb1 container.

Usage:

Save the script to a file, e.g., run_docker.sh.

Make the script executable: chmod +x run_docker.sh.

Run the script: ./run_docker.sh.
