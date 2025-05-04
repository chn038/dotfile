#!/bin/bash

stow -v -R *
cp ssh/.ssh/* $HOME/.ssh

echo "Decrypting id_rsa"
ansible-vault decrypt $HOME/.ssh/id_rsa
echo "Decrypting id_rsa_1"
ansible-vault decrypt $HOME/.ssh/id_rsa_1
