#!/bin/bash

# Function to install packages based on package manager
install_packages() {
    local package_manager=$1
    local packages=$2

    case "$package_manager" in
        apt)
            sudo apt-get update
            sudo apt-get install -y $packages
            ;;
        yum)
            sudo yum install -y $packages
            ;;
        dnf)
            sudo dnf install -y $packages
            ;;
        *)
            echo "Unsupported package manager. Please install the packages manually."
            exit 1
            ;;
    esac
}

# Detect package manager and install required packages
if command -v apt-get &>/dev/null; then
    install_packages "apt" "jp2a figlet lolcat"
elif command -v yum &>/dev/null; then
    install_packages "yum" "epel-release jp2a figlet lolcat"
elif command -v dnf &>/dev/null; then
    install_packages "dnf" "jp2a figlet lolcat"
else
    echo "Unsupported distribution. Please install the packages manually."
    exit 1
fi

# Download the image and rename it
wget -O logo.png https://t3.ftcdn.net/jpg/05/00/93/20/360_F_500932055_cxYNf3ph03cHWl6r2zRRVMLhF8GqQeeC.jpg

# Add banner commands to ~/.bashrc
cat << EOF >> ~/.bashrc

# Print banner
jp2a logo.png --color
figlet -f slant -c "Hi Lucifer" | lolcat
figlet -f digital -c "Welcome to the cyberworld" | lolcat

EOF

# Reload ~/.bashrc to apply changes
source ~/.bashrc

# Display a message indicating that the script has completed
echo "Banner setup completed. You can now open a new terminal to see the banners."
