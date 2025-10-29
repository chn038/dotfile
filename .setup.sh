stow -v -R *
mkdir $HOME/.ssh
cp ssh/.ssh/* $HOME/.ssh

echo "Decrypting id_rsa"
ansible-vault decrypt $HOME/.ssh/id_rsa
echo "Decrypting id_rsa_1"
ansible-vault decrypt $HOME/.ssh/id_rsa_1

echo "Copying rime setting file"
cp .default.custom.yaml $HOME/.local/share/fcitx5/rime/default.custom.yaml
