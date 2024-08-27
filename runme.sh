#!/bin/bash

#current repository as the executable repository
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

#scripts we want to run
SCRIPTS=(
    "docker-installation.sh"
    "fail2ban-setup.sh"
    "services-customization.sh"
    "ufw-setup.sh"
)

#running scripts here
run_script() {
    local script="$1"
    if [[ -x "$SCRIPT_DIR/$script" ]]; then
        echo "Running: $script..."
        "$SCRIPT_DIR/$script"
        if [[ $? -ne 0 ]]; then
            echo "Error while running $script"
            exit 1
        fi
    else
        echo "$script is not found or it is not executable"
        exit 1
    fi
}

#running each script
for script in "${SCRIPTS[@]}"; do
    run_script "$script"
done

echo "All the scripts were completed"
