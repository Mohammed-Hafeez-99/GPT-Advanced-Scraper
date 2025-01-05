#!/bin/bash

# Check if running on Debian-based system
if [ ! -f /etc/debian_version ]; then
    echo "Error: This script requires a Debian-based Linux distribution."
    exit 1
fi

# Check if sudo is available
if ! command -v sudo >/dev/null 2>&1; then
    echo "Error: This script requires sudo privileges."
    exit 1
fi

# Update package list with error handling
sudo apt update -y || {
    echo "Error: Failed to update package list. Please check your internet connection."
    exit 1
}
# Function to check if Google Chrome is installed
check_chrome_installed() {
    if command -v google-chrome &> /dev/null; then
        echo "Google Chrome is already installed."
        return 0
    else
        echo "Google Chrome is not installed."
        return 1
    fi
}

# Function to install Google Chrome
install_chrome() {
    echo "Would you like to install Google Chrome? (y/n) (Requiresd for this to work)"
    read answer
    if [[ "$answer" == "y" ]]; then
        echo "Installing Google Chrome..."
        # Set up cleanup trap
        trap 'rm -f google-chrome.deb' EXIT

        # Download and install Google Chrome (for Debian-based systems)
        if ! wget -q -O google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb; then
            echo "Error: Failed to download Chrome package"
            exit 1
        fi

        # Verify package signature
        if ! wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -; then
            echo "Error: Failed to verify package signature"
            exit 1
        fi

        sudo dpkg -i google-chrome.deb
        if [ $? -ne 0 ]; then
            echo "Resolving dependencies..."
            sudo apt-get install -f -y || {
                echo "Error: Failed to install dependencies"
                exit 1
            }
        fi
        echo "Google Chrome has been installed."
    else
        echo "Exiting without installing Google Chrome."
        exit 0
    fi
}

# Main script execution
check_chrome_installed || install_chrome

# Install Python 3
echo "Installing Python 3"
sudo apt install python3 -y
python3 --version
# Install pip for Python 3
echo "Installing pip for Python 3..."
sudo apt install python3-pip -y
pip3 --version
echo "Python 3 and pip Which was needed was installed succesfully, Now for convienience...."
sudo apt install python-is-python3

# Check if requirements.txt exists
if [ ! -f requirements.txt ]; then
    echo "Error: requirements.txt not found"
    exit 1
fi

echo "Installing necessary Python modules..."
pip install -r requirements.txt || {
    echo "Error: Failed to install Python packages"
    exit 1
}

# Check if app.py exists
if [ ! -f app.py ]; then
    echo "Error: app.py not found"
    exit 1
fi

echo "Running script..."
python app.py || {
    echo "Error: Failed to run app.py"
    exit 1
}

read -p "Press Enter to exit..."
