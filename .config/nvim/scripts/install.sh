mkdir -p /tmp/inst-nvim && cd /tmp/inst-nvim

# neovim
wget https://github.com/neovim/neovim/releases/download/v0.8.2/nvim-linux64.deb
sudo apt install ./nvim-linux64.deb

# trash-cli ( by nvim-tree )
sudo apt install trash-cli

# treesitter
sudo apt install g++

# rg, fd(telescope)
sudo apt install ripgrep fd-find

sudo apt install python3-pip

# python venv
sudo apt install python3-venv

# clean
rm -rf /tmp/inst-nvim
