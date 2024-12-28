#!/bin/bash

# Function to run a new container
run_new_container() {
    clear
    echo "=== Run a New Container ==="
    read -p "Enter image name: " image_name
    read -p "Enter container name: " container_name
    docker run -d --name "$container_name" "$image_name"
}

# Function to manage existing containers
manage_containers() {
    clear
    echo "=== Manage Containers ==="
    echo "1. List containers"
    echo "2. Stop container"
    echo "3. Start container"
    echo "4. Remove container"
    
    read -p "Enter choice: " container_choice
    
    case $container_choice in
        1)
            docker ps -a
            ;;
        2)
            read -p "Enter container name/ID: " container_id
            docker stop "$container_id"
            ;;
        3)
            read -p "Enter container name/ID: " container_id
            docker start "$container_id"
            ;;
        4)
            read -p "Enter container name/ID: " container_id
            docker rm -f "$container_id"
            ;;
    esac
}

# Function to manage images
manage_images() {
    clear
    echo "=== Manage Images ==="
    echo "1. List images"
    echo "2. Pull image"
    echo "3. Remove image"
    
    read -p "Enter choice: " image_choice
    
    case $image_choice in
        1)
            docker images
            ;;
        2)
            read -p "Enter image name: " image_name
            docker pull "$image_name"
            ;;
        3)
            read -p "Enter image name/ID: " image_id
            docker rmi "$image_id"
            ;;
    esac
}

# Function to manage volumes
manage_volumes() {
    clear
    echo "=== Manage Volumes ==="
    echo "1. List volumes"
    echo "2. Create volume"
    echo "3. Remove volume"
    
    read -p "Enter choice: " volume_choice
    
    case $volume_choice in
        1)
            docker volume ls
            ;;
        2)
            read -p "Enter volume name: " volume_name
            docker volume create "$volume_name"
            ;;
        3)
            read -p "Enter volume name: " volume_name
            docker volume rm "$volume_name"
            ;;
    esac
}

# Function to manage networks
manage_networks() {
    clear
    echo "=== Manage Networks ==="
    echo "1. List networks"
    echo "2. Create network"
    echo "3. Remove network"
    
    read -p "Enter choice: " network_choice
    
    case $network_choice in
        1)
            docker network ls
            ;;
        2)
            read -p "Enter network name: " network_name
            docker network create "$network_name"
            ;;
        3)
            read -p "Enter network name: " network_name
            docker network rm "$network_name"
            ;;
    esac
}

# Function to clean up system
system_cleanup() {
    clear
    echo "=== System Cleanup ==="
    echo "1. Remove unused containers"
    echo "2. Remove unused images"
    echo "3. Remove unused volumes"
    echo "4. Remove all unused resources"
    
    read -p "Enter choice: " cleanup_choice
    
    case $cleanup_choice in
        1)
            docker container prune -f
            ;;
        2)
            docker image prune -f
            ;;
        3)
            docker volume prune -f
            ;;
        4)
            docker system prune -af
            ;;
    esac
}

# Function to view logs
view_logs() {
    clear
    echo "=== Container Logs ==="
    read -p "Enter container name/ID: " container_id
    docker logs -f "$container_id"
}

# Function to view stats
view_stats() {
    clear
    echo "=== Container Stats ==="
    docker stats
}

# Function for file operations
file_operations() {
    clear
    echo "=== File Operations ==="
    echo "1. Copy file to container"
    echo "2. Copy file from container"
    
    read -p "Enter choice: " file_choice
    
    case $file_choice in
        1)
            read -p "Enter container name/ID: " container_id
            read -p "Enter source path: " source_path
            read -p "Enter destination path: " dest_path
            docker cp "$source_path" "$container_id:$dest_path"
            ;;
        2)
            read -p "Enter container name/ID: " container_id
            read -p "Enter source path: " source_path
            read -p "Enter destination path: " dest_path
            docker cp "$container_id:$source_path" "$dest_path"
            ;;
    esac
}

# Function to create Dockerfile
create_dockerfile() {
    clear
    echo "=== Create Dockerfile ==="
    read -p "Enter directory path: " dockerfile_dir
    mkdir -p "$dockerfile_dir"
    read -p "Enter base image: " base_image
    
    cat > "$dockerfile_dir/Dockerfile" << EOF
FROM $base_image
WORKDIR /app
COPY . .
CMD ["bash"]
EOF
    
    echo "Basic Dockerfile created at $dockerfile_dir/Dockerfile"
}

# Function to create docker-compose.yml
create_docker_compose() {
    clear
    echo "=== Create Docker Compose File ==="
    
    # Get compose file location
    read -p "Enter directory path for docker-compose.yml: " compose_dir
    mkdir -p "$compose_dir"
    compose_file="$compose_dir/docker-compose.yml"
    
    # Initialize compose file
    echo "version: '3.8'" > "$compose_file"
    echo "services:" >> "$compose_file"
    
    # Add services
    while true; do
        read -p "Add a service? (y/n): " add_service
        if [ "$add_service" != "y" ]; then
            break
        fi
        
        # Service name
        read -p "Enter service name: " service_name
        echo "  $service_name:" >> "$compose_file"
        
        # Image or build
        echo "Choose image source:"
        echo "1. Use existing image"
        echo "2. Build from Dockerfile"
        read -p "Enter choice: " image_choice
        
        if [ "$image_choice" = "1" ]; then
            read -p "Enter image name: " image_name
            echo "    image: $image_name" >> "$compose_file"
        else
            read -p "Enter Dockerfile path: " dockerfile_path
            echo "    build:" >> "$compose_file"
            echo "      context: ." >> "$compose_file"
            echo "      dockerfile: $dockerfile_path" >> "$compose_file"
        fi
        
        # Container name
        read -p "Set container name? (y/n): " set_container_name
        if [ "$set_container_name" = "y" ]; then
            read -p "Enter container name: " container_name
            echo "    container_name: $container_name" >> "$compose_file"
        fi
        
        # Ports
        read -p "Map ports? (y/n): " map_ports
        if [ "$map_ports" = "y" ]; then
            echo "    ports:" >> "$compose_file"
            while true; do
                read -p "Enter port mapping (HOST:CONTAINER) or 'done' to finish: " port_map
                if [ "$port_map" = "done" ]; then
                    break
                fi
                echo "      - \"$port_map\"" >> "$compose_file"
            done
        fi
        
        # Environment variables
        read -p "Add environment variables? (y/n): " add_env
        if [ "$add_env" = "y" ]; then
            echo "    environment:" >> "$compose_file"
            while true; do
                read -p "Enter environment variable (KEY=value) or 'done' to finish: " env_var
                if [ "$env_var" = "done" ]; then
                    break
                fi
                echo "      - $env_var" >> "$compose_file"
            done
        fi
    done
    
    echo -e "\nDocker Compose file created successfully at $compose_file"
    echo -e "\nFile contents:"
    cat "$compose_file"
}

# Function to run docker-compose services
run_docker_compose() {
    clear
    echo "=== Run Docker Compose Services ==="
    
    read -p "Enter path to docker-compose.yml directory: " compose_dir
    if [ ! -f "$compose_dir/docker-compose.yml" ]; then
        echo "docker-compose.yml not found in specified directory!"
        return 1
    fi
    
    cd "$compose_dir"
    
    echo "Select operation:"
    echo "1. Start services"
    echo "2. Start services in detached mode"
    echo "3. Start specific service"
    
    read -p "Enter choice: " run_choice
    
    case $run_choice in
        1)
            docker-compose up
            ;;
        2)
            docker-compose up -d
            ;;
        3)
            read -p "Enter service name: " service_name
            docker-compose up -d "$service_name"
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
}

# Function to manage running compose services
manage_compose_services() {
    clear
    echo "=== Manage Compose Services ==="
    
    read -p "Enter path to docker-compose.yml directory: " compose_dir
    if [ ! -f "$compose_dir/docker-compose.yml" ]; then
        echo "docker-compose.yml not found in specified directory!"
        return 1
    fi
    
    cd "$compose_dir"
    
    echo "Select operation:"
    echo "1. List services"
    echo "2. Stop services"
    echo "3. Restart services"
    echo "4. View logs"
    echo "5. Remove services"
    
    read -p "Enter choice: " manage_choice
    
    case $manage_choice in
        1)
            docker-compose ps
            ;;
        2)
            docker-compose stop
            ;;
        3)
            docker-compose restart
            ;;
        4)
            read -p "Follow logs? (y/n): " follow_logs
            if [ "$follow_logs" = "y" ]; then
                docker-compose logs -f
            else
                docker-compose logs
            fi
            ;;
        5)
            read -p "Remove volumes too? (y/n): " remove_volumes
            if [ "$remove_volumes" = "y" ]; then
                docker-compose down -v
            else
                docker-compose down
            fi
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
}

# Function for Docker Compose operations menu
docker_compose_operations() {
    clear
    echo "=== Docker Compose Operations ==="
    echo "1. Create new docker-compose.yml"
    echo "2. Run docker-compose services"
    echo "3. Manage running compose services"
    echo "4. Back to main menu"
    
    read -p "Enter your choice: " compose_choice
    
    case $compose_choice in
        1)
            create_docker_compose
            ;;
        2)
            run_docker_compose
            ;;
        3)
            manage_compose_services
            ;;
        4)
            return
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
}

# Main menu function
show_menu() {
    clear
    echo "=== Docker Management Script ==="
    echo "1. Run a new container"
    echo "2. Manage existing containers"
    echo "3. Manage images"
    echo "4. Manage volumes"
    echo "5. Manage networks"
    echo "6. System cleanup"
    echo "7. Container logs"
    echo "8. Container stats"
    echo "9. File Operations"
    echo "10. Create Dockerfile"
    echo "11. Docker Compose Operations"
    echo "12. Exit"
}

# Main loop
while true; do
    show_menu
    read -p "Enter your choice (1-12): " choice
    
    case $choice in
        1) run_new_container ;;
        2) manage_containers ;;
        3) manage_images ;;
        4) manage_volumes ;;
        5) manage_networks ;;
        6) system_cleanup ;;
        7) view_logs ;;
        8) view_stats ;;
        9) file_operations ;;
        10) create_dockerfile ;;
        11) docker_compose_operations ;;
        12)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please enter a number between 1 and 12."
            ;;
    esac
    
    echo
    read -p "Press Enter to continue..."
done
