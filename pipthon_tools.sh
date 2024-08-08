#!/bin/bash

# Cleaning up python default installations
sudo find /usr/bin -name "python*" -delete

# Installing dependency packages
sudo apt update
sudo apt upgrade -y
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo add-apt-repository ppa:git-core/ppa
sudo apt update

if [[ ! $(find /etc -name "localtime") ]]; then
  echo "Localtime not found, creating..."
  sudo DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata
  sudo ln -fs /usr/share/zoneinfo/Europe/Madrid /etc/localtime
  sudo dpkg-reconfigure --frontend noninteractive tzdata
fi

# Insatlling python3.10 independantly because of its peculiarity
echo "Installing python3.10"
sudo apt install python3.10 -y
sudo apt install python3.10-venv -y
sudo apt install python3-pip -y
echo "Checking pipthon versions: python $(python3.10 --version) with pip $(pip3.10 --version)"

# Deleting the new python and pip 3.10 defaults
sudo rm /usr/bin/python3
sudo rm /usr/bin/python
sudo rm /usr/bin/pip3
sudo rm /usr/bin/pip

# Installing all the python versions from 7 to 11
declare -a versions=("7" "8" "9" "11")
for i in "${versions[@]}"; do
  echo "Installing python3.$i"
  sudo apt install python3.$i -y
  sudo apt install python3.$i-venv -y
  python3.$i -m ensurepip --upgrade
  sudo ln -s $HOME/.local/bin/pip3.$i /usr/bin/pip3.$i
  echo "Checking pipthon versions: python $(python3.$i --version) with pip $(pip3.$i --version)"
done

# Setting python and pip 3.9 as the default ones
sudo ln -s /usr/bin/python3.11 /usr/bin/python3
sudo ln -s /usr/bin/python3.11 /usr/bin/python
sudo ln -s $HOME/.local/bin/pip3.11 /usr/bin/pip3
sudo ln -s $HOME/.local/bin/pip3.11 /usr/bin/pip

pip install six testresources poetry
sudo ln -s $HOME/.local/bin/poetry /usr/bin/poetry
echo "Checking poetry version: $(poetry --version) on path $(which poetry)"

# Install zsh
sudo apt install zsh -y
echo $(zsh --version)
chsh -S /bin/zsh
export SHELL=/bin/zsh
echo $SHELL

# Install curl
sudo apt install curl -y

# Install and configure git
sudo apt install git -y

#################################################
# Configure git with credentials
# cat > .gitconfig << EOF
# Line 1
# Line 2
# Line 3
# EOF

# Install "oh my zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Configure "oh my zsh" and zshrc file
cp ~/.zshrc ~/.zshrc.backup

# Install the powerline fonts
sudo apt install fonts-powerline

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

# Install the powerlvl10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
sed -i '/^ZSH_THEME/c\ZSH_THEME="powerlevel10k/powerlevel10k"' ~/.zshrc

# Install zsh useful plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
sed -i '/^plugins=/c\plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' ~/.zshrc
