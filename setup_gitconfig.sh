#! /bin/bash
_env=$( dirname -- "${BASH_SOURCE[0]}" )

while [[ $name = "" ]]; do
    printf "Enter Git Name: "
    read name
done

while [[ $username = "" ]]; do
    printf "Enter Git username: "
    read username
done

while [[ $email = "" ]]; do
    printf "Enter Git email: "
    read email
done

printf "Enter default editor or hit enter for default (Nano): "
read editor

git config --global user.name $name
git config --global user.email $email
git config --global user.username $username
git config --global safe.directory "*"
git config --global commit.template $_env/git_commit_msg_template.txt
if [ ! -z "$editor" ]; then
    git config --global core.editor $editor
fi

# Install gitub cli
printf "Would you like to install GitHub CLI (Y/n): "
read cli_install
if [ $cli_install = "y" || $cli_install = "Y" ]; then
    # Install GitHub CLI
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install gh
    # Authenticate with github cli.
    gh auth login
else
    printf "Please copy your ssh public key to github keys: https://github.com/settings/keys: \n\n"
    cat ~/.ssh/id_rsa.pub
    echo ""
fi
