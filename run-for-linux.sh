#!/bin/bash
sudo apt update -y
# Function to check if Google Chrome is installed
check_chrome_installed() {
    if command -v google-chrome &> /dev/null; then
        echo "Google Chrome is already installed."
        exit 0
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
        # Download and install Google Chrome (for Debian-based systems)
        wget -q -O google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo dpkg -i google-chrome.deb
        sudo apt-get install -f  # Fix any dependency issues
        rm google-chrome.deb  # Clean up
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

echo "Installing necessary Python modules..."
pip install -r requirements.txt
echo "Running script..."
python app.py
read -p "enter the required prompt...."
