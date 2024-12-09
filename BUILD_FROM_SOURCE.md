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
version="6.6.13"
wget https://ftp.gnu.org/pub/gnu/global/global-${version}.tar.gz
tar -xvf global-$version.tar.gz
cd global-$version/
./configure --prefix="$HOME/.local" --with-sqlite3
make
make install
```

# [clangd](https://github.com/llvm/llvm-project)

deps:

- cmake
- gcc
- python3
- zlib
- gnu make

```bash
version=19.1.5
wget https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-${version}.tar.gz
tar -xvf llvmorg-${version}.tar.gz
cd llvm-project-llvmorg-${version}/
mkdir -p build && cd build
cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS='clang;clang-tools-extra' ../llvm
cmake --build . --target clangd
```
