# TODO

# nvim 配置结构

配置的主要结构如下

```
├── init.vim
├── lua/user
│       ├── basic/
│       ├── conf/
│       ├── dap/
│       ├── lang/
│       ├── lsp/
│       └── plugins.lua
├── my-snippets
│   ├── luasnippets/
│   ├── snippets/ # snipmate格式(*.snippets)或者vsnip格式(*.json)
│   └── Ultisnips/
├── README.md
├── static
│   ├── latexmkrc
│   ├── pyproject.toml
│   └── tasks.ini
└── templates/
```

以`init.vim`为入口文件,主要是为了兼顾偶尔用 vim 的场景，在 vim 模式下不加载任何外部插件.

```vim
" vim config, no dependences, vi not supported
source ~/.config/nvim/lua/user/basic/options.vim
source ~/.config/nvim/lua/user/basic/keymaps.vim
source ~/.config/nvim/lua/user/basic/autocmd.vim
colorscheme desert

if has("nvim")
    colorscheme nightfox
    lua require("user.plugins") " lua文件，加载插件
    lua require("user.conf") " 插件的配置
    lua require("user.lsp") " lsp
    lua require("user.dap") " dap
    lua require("user.lang") " 对具体语言的配置
endif
```

# 配置细节

## user/basic

在`~/.config/nvim/lua/user/basic`目录下有几个`vim`配置文件,是 vim 和 nvim
共用的, 具体的去看文件这几个文件吧,没什么好说的.

## user/conf

这里的插件配置都是自动加载的,放置的一般是和 lsp,dap,具体的语言无关的插件配置

## user/lsp

使用 neovim 内置的 lsp client 时,lsp 的配置一般都比较麻烦,这里提供了一种比较方案并简单说明

### lsp 的安装

lsp server 采用`mason`插件进行安装管理,但是`mason`中使用的 package 名称和`lspconfig`插件使用的 server
name 是不一致的,所以增加了`mason-lspconfig`插件,那就可以用`LspInstall`进行安装了

### lsp server 的启动和配置

通过 mason 安装的 lsp server 自动启动,server 的启动参数用 yaml 编写,位于`lua/user/lsp/nlsp-settings`

### 相关插件

下面的插件都只是增强内置的 lsp 功能,例如跳转,查询引用等.

- `lspsaga`

- `lsp-signature`

## user/dap

dap 的配置其实也比较简单,主要分两块,一个是`dap-ui.lua`,决定了 debug 界面的样子,各个 window 的位置和大小,另一个是`dap-config.lua`,定义了 dap 任务和启动等

`dap-config.lua`文件中主要有以下几个函数

- `config_signs`: 定义了 dap 的符号
- `config_event`: 配置了启动和结束 dap 时的动作
- `config_breakpoints`: 通过插件持久化断点配置,并定义了几个相关命令
- `config_adapter`: adapter 通过`mason`安装,和 lsp 的时候配置,通过`mason-nvim-dap`插件,可以用`DapInstall`命令安装 adapter,然后配置了自动启动,除了定义在配置文件中的 dap task,还可以读取项目目录下 vscode 定义的 task,位于`.vscode/launch.json`.

## user/lang
