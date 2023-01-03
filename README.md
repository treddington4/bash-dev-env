The bash-dev-environment repo introduces common aliases and functions into your bash environment. Running the `setup_environment.sh` script will add the following block of code to the `.bashrc` file located in the `$HOME` directory.

**Example**:
```
# sourcing bash development enviroment
if [ -f $HOME/bash-dev-environment/.bash_dev_includes ]; then
   . $HOME/bash-dev-environment/.bash_dev_includes
fi
```
# bashconfig
Initialize repo in home

```
cd ~
git clone git@github.com:treddington4/bash-dev-env.git

./bash-dev-environment/setup_environ.sh
```

The `setup_environ.sh` calls the scripts `setup_ssh.sh` and `setup_gitconfig.sh` and they should not be called seperatly.

# Introduced functions

| Function       | Behavior  |
| ---            | --- |
| blame          | determine how many processes are used by each user. Has a parameter to specify a specific process |
| whatamirunning | List all processes started by $USER |
| killbitbake    |designed to kill all bitbake processes and remove `LOCK` and `SOCK` files when run in build directory |
| sstate_check   | Determine how much space will be freed from the sstate tomorrow |
| killme         | Destroy all processes started by $USER. Used in the event you have too many processes running and you want to take a hammer to the solution |

# Introduced aliases
| Alias                 | Command  |
| ---                   | --- |
| sourceme              | `. ~/.bashrc` |
| reload                | `. ~/.bashrc` |
| gitreview             | `git-review` |
| sit                   | `git` |

# Windows Subsystem Linux (WSL) DOCKER
To configure run the `configure_wsl_docker.sh` script. This configures docker for use in WSL without needing to use docker desktop. Only needs to be run once.
Adds the aliases:
| Alias                 | Command  |
| ---                   | --- |
| dockerd | `sudo dockerd -H \$(ip address show eth0 \| grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" \| grep -v 127.0.0.1 \| awk '{ print \$2 }' \| cut -f1 -d/)` |
| docker  | `docker -H \$(ip address show eth0 \| grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" \| grep -v 127` |

To use docker on WSL, you need to start dockerd as a background process
issue commands `dockerd` Enter your `[sudo] password` then hit `ctrl` + `z` then issue `bg` command

This will open the docker tcp port which will allow docker to run as normal.
