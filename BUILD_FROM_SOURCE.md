# [neovim](https://github.com/neovim/neovim)

```bash
git clone https://github.com/neovim/neovim.git
cd neovim/
git checkout stable
make CMAKE_INSTALL_PREFIX="$HOME/.local/"
make install
```

# [universal-ctags](https://github.com/universal-ctags/ctags)

```bash
git clone https://github.com/universal-ctags/ctags.git universal-ctags
cd universal-ctags
./autogen.sh
./configure --prefix="$HOME/.local/"
make
make install
```

# [gtags](https://ftp.gnu.org/pub/gnu/global/)

```bash
version="6.6"
wget https://ftp.gnu.org/pub/gnu/global/global-$version.tar.gz
tar -xvf global-$version.tar.gz
cd global-$version/
sh reconf.sh
./configure --prefix="$HOME/.local"
make
make install
```
