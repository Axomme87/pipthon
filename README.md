# PIPTHON INSTALLER

## ABOUT

This is an unattended installation for a freshly installed ubuntu:22.0.4 distribution that installs the required
timezone according to Madrid, then all python, venv and pip versions from 3.7 to 3.11 making the 3.9 the default one by
exposing the binaries through symbolic links and at last installs poetry while exposing the binary as executable also
through a symbolic link.

## Motivation

This process is often needed for python developers to have all the variety of python tools to be able to interact with
from the get-go. This process makes it easier to install all the different versions from one shell script.

## TO DO:

+ Add more installable tools such as Terraform, nvm, npm, node, awscli, azcli, sls, make, kubectl, git, etc
+ combine these installations with visual .dotfiles for installing and configuring oh-my-zsh with powerlevel11k
+ add git and other shortcuts for and differentiate them from being native or WSL
+ TBD
