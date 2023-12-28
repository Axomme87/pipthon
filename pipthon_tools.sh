#!/bin/bash

# Cleaning up python default installations
sudo find /usr/bin -name "python*" -delete

# Installing dependency packages
sudo apt update
sudo apt upgrade -y
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y

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
sudo ln -s /usr/bin/python3.9 /usr/bin/python3
sudo ln -s /usr/bin/python3.9 /usr/bin/python
sudo ln -s $HOME/.local/bin/pip3.9 /usr/bin/pip3
sudo ln -s $HOME/.local/bin/pip3.9 /usr/bin/pip

pip install six testresources poetry
sudo ln -s $HOME/.local/bin/poetry /usr/bin/poetry
echo "Checking poetry version: $(poetry --version) on path $(which poetry)"
