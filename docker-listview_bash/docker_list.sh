#!/bin/bash

# Function to display Docker container list in a tree format
function docker_list_tree_view() {
    # Check if Docker is installed
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed. Please install Docker."
        exit 1
    fi

    # Fetching container information
    containers=$(docker ps -a --format "{{.ID}}: {{.Image}} ({{.Names}})")

    # If no containers are found
    if [ -z "$containers" ]; then
        echo "No Docker containers found."
        return
    fi

    # Display the list of Docker containers in tree format
    echo "Listing Docker containers in tree format..."
    echo ""

    # Initialize an array to hold the container names
    container_names=()
    
    # Loop through each container and populate the array
    while IFS= read -r line; do
        container_names+=("$line")
    done <<< "$containers"

    # Print containers in a tree structure
    for container in "${container_names[@]}"; do
        # Split container ID and details
        IFS=': ' read -r id details <<< "$container"
        
        # Get container name and image
        container_name=$(echo "$details" | awk -F' ' '{print $1}')
        image_name=$(echo "$details" | awk -F' ' '{print $2}')
        
        # Print in tree format
        echo "├── $container_name [$image_name]"
    done

    echo ""
    echo "Total containers: ${#container_names[@]}"
}

# Call the function
docker_list_tree_view
