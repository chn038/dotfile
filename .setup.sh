#!/bin/bash
stow -v -R *
mkdir $HOME/.ssh
cp ssh/.ssh/* $HOME/.ssh

echo "Decrypting id_rsa"
ansible-vault decrypt $HOME/.ssh/id_rsa
echo "Decrypting id_rsa_1"
ansible-vault decrypt $HOME/.ssh/id_rsa_1
echo "Copying emoji"
wget https://raw.githubusercontent.com/rainlime/fcitx-quick-phrase-emoji/master/QuickPhrase.mb && cat ./QuickPhrase.mb >> ~/.config/fcitx/data/QuickPhrase.mb && rm ./QuickPhrase.mb
