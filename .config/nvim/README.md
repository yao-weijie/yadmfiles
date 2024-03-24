# 个人自用Neovim 配置

neovim 最新版本

```bash
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod +x nvim.appimage && sudo mv nvim.appimage /usr/local/bin/nvim
```

依赖的命令行工具

- g++
- fzf
- fd-find
- ripgrep
- batcat
- trash-cli
- python3-pip
- python3-venv
- npm
- nodejs

## 插件

### 插件管理器

- `folke/lazy.nvim`

### 模糊搜索

- `ibhagwan/fzf-lua`

### mason下载管理

- `williamboman/mason.nvim`
- `williamboman/mason-lspconfig.nvim`
- `jayp0521/mason-nvim-dap.nvim`
- `jay-babu/mason-null-ls.nvim`

### lsp

- `neovim/nvim-lspconfig`
- `folke/neodev.nvim`
- `hrsh7th/cmp-nvim-lsp`
- `williamboman/mason-lspconfig.nvim`
- `nvimdev/lspsaga.nvim`

### 编辑

- `numToStr/Comment.nvim`
- `windwp/nvim-autopairs`
- `nvim-pack/nvim-spectre`
- `kylechui/nvim-surround`

### UI美化

- `olimorris/onedarkpro.nvim`
- `nvimdev/dashboard-nvim`
- `stevearc/dressing.nvim`
- `lukas-reineke/indent-blankline.nvim`
- `nvim-lualine/lualine.nvim`
- `folke/noice.nvim`

### 其他工具插件

- `stevearc/aerial.nvim`
- `skywind3000/asynctasks.vim`
- `skywind3000/asyncrun.vim`
- `folke/flash.nvim`
- `lewis6991/gitsigns.nvim`
- `sindrets/diffview.nvim`
- `nvim-tree/nvim-tree.lua`
- `akinsho/toggleterm.nvim`
- `folke/which-key.nvim`
