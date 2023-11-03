# neovim
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod +x nvim.appimage && sudo mv nvim.appimage /usr/local/bin/nvim

# trash-cli ( by nvim-tree )
sudo apt install trash-cli

# treesitter
sudo apt install g++

# rg, fd(telescope)
sudo apt install ripgrep fd-find

sudo apt install python3-pip python3-venv

# clean
rm -rf /tmp/inst-nvim
