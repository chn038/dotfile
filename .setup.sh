#!/bin/bash
stow -v -R *
mkdir $HOME/.ssh
cp ssh/.ssh/* $HOME/.ssh

echo "Decrypting id_rsa"
ansible-vault decrypt $HOME/.ssh/id_rsa
echo "Decrypting id_rsa_1"
ansible-vault decrypt $HOME/.ssh/id_rsa_1
echo "Copying secret and decrypting"
cp .sec $HOME/.sec
ansible-vault decrypt $HOME/.sec

echo "Importing gpg keypairs"
cp gpg/.prv.key $HOME/.prv.key
cp gpg/.pub.key $HOME/.pub.key
echo "Decrypting .prv.key"
ansible-vault decrypt $HOME/.prv.key
echo "Decrypting .pub.key"
ansible-vault decrypt $HOME/.pub.key
echo "Importing keys..."
gpg --import $HOME/.prv.key
gpg --import $HOME/.pub.key
echo "Checking gpg..."
gpg --list-keys
echo "Deleting copied keys..."
rm $HOME/.prv.key
rm $HOME/.pub.key
echo "Finished!"
