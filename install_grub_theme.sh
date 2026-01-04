#!/bin/bash

# TODO use https://github.com/pizzasqueeze/Thinkpad-Grub-Theme instead
# Directory to clone the repository into
REPO_DIR="$PWD/HyperFluent-GRUB-Theme"

# If the repository already exists, pull the latest changes
if [ -d "$REPO_DIR" ]; then
    cd "$REPO_DIR"
    git pull
    if [ $? -ne 0 ]; then
        exit 1
    fi
    cd -
else
    git clone https://github.com/Coopydood/HyperFluent-GRUB-Theme.git "$REPO_DIR"
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi

# Copy to /boot instead of /usr/share (which is typically encrypted)
sudo mkdir -p /boot/grub/themes
sudo cp -r $REPO_DIR/arch /boot/grub/themes/fluent

echo
echo -e "\e[1;33mTo complete the installation, please set GRUB_THEME=\"/boot/grub/themes/fluent/theme.txt\" in /etc/default/grub,\e[0m"
echo -e "\e[1;33mset GRUB_TERMINAL_OUTPUT=\"console\" to GRUB_TERMINAL_OUTPUT=\"gfxterm\".\e[0m"
echo -e "\e[1;33mand add "splash" to GRUB_CMDLINE_LINUX_DEFAULT (for Plymouth support).\e[0m"
echo
echo "Press Enter to open /etc/default/grub for editing..."
read

sudo nano /etc/default/grub
echo
echo "Press Enter to regenerate GRUB config..."
read
sudo grub-mkconfig -o /boot/grub/grub.cfg