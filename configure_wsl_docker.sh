#! /bin/bash
# Source came from:
# https://dev.to/_nicolas_louis_/how-to-run-docker-on-windows-without-docker-desktop-hik

# Determine if running on wsl
cat /proc/sys/kernel/osrelease | grep -E "microsoft|WSL"
osrelease=$?
cat /proc/version | grep -E "microsoft|WSL"
version=$?

SUCCESS=0

if [[ $osrelease -ne $SUCCESS || $version -ne $SUCCESS ]]; then
    echo "This script is designed to run on WSL only"
else
    # Verify sudo
    grep -E 'sudo|wheel' /etc/group | grep $USER
    is_sudoer=$?
    if [[ $is_sudoer -ne $SUCCESS ]]; then
        usermod -aG sudo $USER
    fi

    # Remove Residue from previous docker installations
    sudo apt remove docker docker-engine docker.io containerd runc

    # Debian/Ubuntu package repository configuration
    source /etc/os-release

    # Trust the repo
    curl -fsSL https://download.docker.com/linux/${ID}/gpg | sudo apt-key add -

    # Update repo info :
    echo "deb [arch=amd64] https://download.docker.com/linux/${ID} ${VERSION_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/docker.list
    sudo apt update

    # Install official Docker release
    sudo apt install iproute2 docker-ce docker-ce-cli containerd.io

    # Add user to docker group
    sudo usermod -aG docker $USER

    docker_aliases=$(cat ~/.bash_aliases | grep -i "alias dockerd=")
    if [ -z "${docker_aliases}" ]; then
        cat >> ~/.bash_aliases << EOF
# Setup docker aliases
alias dockerd="sudo dockerd -H \$(ip address show eth0 | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print \$2 }' | cut -f1 -d/)"
alias docker="docker -H \$(ip address show eth0 | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print \$2 }' | cut -f1 -d/)"
EOF

    fi
    printf "\nDocker has been setup, Please re-launch the WSL window\n"
fi
