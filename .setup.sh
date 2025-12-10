#!/bin/bash
stow -v -R *
mkdir $HOME/.ssh
cp ssh/.ssh/* $HOME/.ssh

echo "Decrypting id_rsa"
ansible-vault decrypt $HOME/.ssh/id_rsa
echo "Decrypting id_rsa_1"
ansible-vault decrypt $HOME/.ssh/id_rsa_1
echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

