#! /bin/bash
_source_path=$PWD
_env=$( dirname -- "${BASH_SOURCE[0]}" )
# setup local paths for adding to home directory
cd $_env

echo "setting up .inputrc"
if [ -f ~/.inputrc ]; then
    if [ -z "$(cat ~/.inputrc | grep "set completion-ignore-case on")" ]; then
        printf "set completion-ignore-case on\n" >> ~/.inputrc
    fi
else
    printf "set completion-ignore-case on\n" >> ~/.inputrc
fi

echo "setting up bash functions and aliases"
dev_env_added=$(cat ~/.bashrc | grep -i ".bash-dev-env")
if [ -z "${dev_env_added}" ]; then
    printf "\n# sourcing bash development enviroment\n" >>  ~/.bashrc
    printf "if [ -f $PWD/.bash-dev-env ]; then\n" >>  ~/.bashrc
    printf "   . $PWD/.bash-dev-env\n" >>  ~/.bashrc
    printf "fi\n" >>  ~/.bashrc
fi

result=""
printf "Configute SSH? (Y/n): "
read result
if [[ $result == "Y" ]]; then
    # Configure ssh
    $PWD/setup_ssh.sh
fi

result=""
printf "Configute git? (Y/n): "
read result
if [[ $result == "Y" ]]; then
    # Configure git
    $PWD/setup_gitconfig.sh
fi
#  last line restore current path
cd $_source_path

# Source the new aliases
. ~/.bashrc
