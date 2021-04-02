vim.cmd "packadd paq-nvim" -- Load package
local paq = require "paq-nvim".paq -- Import module and bind `paq` function
paq {"savq/paq-nvim", opt = true} -- Let Paq manage itself
paq {"neovim/nvim-lspconfig"}
paq {"tpope/vim-surround"}
paq {"hoob3rt/lualine.nvim"}
paq {"tjdevries/nlua.nvim"}
paq {"kyazdani42/nvim-web-devicons"}
paq {"kyazdani42/nvim-tree.lua"}
paq {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
paq {"sainnhe/sonokai"}
paq {"nvim-lua/completion-nvim"}
paq {"steelsojka/completion-buffers"}
paq {"nvim-treesitter/completion-treesitter"}
paq {"romainl/vim-qf"}

paq {"b3nj5m1n/kommentary"}
paq {"jiangmiao/auto-pairs"}
paq {"phaazon/hop.nvim"}

paq {"junegunn/fzf", hook = vim.fn["fzf#install"]}
paq {"junegunn/fzf.vim"}
paq {"ojroques/nvim-lspfuzzy"}

paq {"kosayoda/nvim-lightbulb"}

paq {"nvim-lua/popup.nvim"}
paq {"nvim-lua/plenary.nvim"}
paq {"nvim-telescope/telescope.nvim"}

paq {"christoomey/vim-tmux-navigator"}

paq {"jeffkreeftmeijer/vim-numbertoggle"}

paq {"jparise/vim-graphql"}
paq {"onsails/lspkind-nvim"}

paq {"hrsh7th/vim-vsnip"}
paq {"hrsh7th/vim-vsnip-integ"}

paq {"direnv/direnv.vim"}
paq {"tpope/vim-fugitive"}
paq {"haya14busa/is.vim"}
paq {"haya14busa/vim-asterisk"}
paq {"bronson/vim-visual-star-search"}
paq {"tpope/vim-repeat"}

paq {"nanotee/sqls.nvim"}
paq {"lukas-reineke/indent-blankline.nvim"}
paq {"lewis6991/gitsigns.nvim"}
paq {"buoto/gotests-vim"}

-- The "run" command might not work. Manual install can be done
-- by running "yarn install" in
-- $HOME/.local/share/nvim/site/pack/paqs/start/markdown-preview.nvim/app
paq {"iamcco/markdown-preview.nvim", run = "cd app & yarn install"}

vim.g.mapleader = ","

vim.api.nvim_exec(
    [[
set encoding=utf8
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Show tab and space
set list
set listchars=tab:‣\ ,trail:·
]],
    false
)

local nvim_lsp = require("lspconfig")
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    require("lspkind").init({})

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = {noremap = true, silent = true}
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    buf_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        vim.api.nvim_exec(
            [[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil,1000)
         augroup END
         ]],
            true
        )
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "gf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
            false
        )
    end
end

-- put LSP diagnostics into quickfix
--https://github.com/neovim/nvim-lspconfig/issues/69#issuecomment-789541466
do
    local pub_method = "textDocument/publishDiagnostics"
    local default_handler = vim.lsp.handlers[pub_method]
    vim.lsp.handlers[pub_method] = function(err, method, result, client_id, bufnr, config)
        default_handler(err, method, result, client_id, bufnr, config)
        local diagnostics = vim.lsp.diagnostic.get_all()
        local qflist = {}
        for nbufnr, diagnostic in pairs(diagnostics) do
            for _, d in ipairs(diagnostic) do
                d.bufnr = nbufnr
                d.lnum = d.range.start.line + 1
                d.col = d.range.start.character + 1
                d.text = d.message
                table.insert(qflist, d)
            end
        end
        vim.lsp.util.set_qflist(qflist)
    end
end
vim.api.nvim_exec(
    [[
nmap <leader>qq	<Plug>(qf_qf_toggle)
nmap gn		<Plug>(qf_qf_next)
nmap gp		<Plug>(qf_qf_previous)
]],
    false
)

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {on_attach = on_attach}
end

local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

nvim_lsp.tsserver.setup {
    cmd = {"typescript-language-server", "--stdio"},
    on_attach = function(client)
        -- Because we are using prettier via ALE
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
    end,
    commands = {
        OrganizeImports = {
            organize_imports,
            description = "Organize Imports"
        }
    }
}

nvim_lsp.graphql.setup {
    filetypes = {"graphql", "javascript"}
}

-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim
nvim_lsp.gopls.setup {
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            analyses = {
                unusedparams = true
            },
            staticcheck = true
        }
    },
    on_attach = on_attach
}

nvim_lsp.yamlls.setup {
    settings = {
        yaml = {
            schemaStore = {enable = true},
            validate = {enable = true},
            hover = {enable = true},
            completion = {enable = true}
        }
    },
    on_attach = on_attach
}

nvim_lsp.sqls.setup {
    cmd = {"sqls", "-config", "~/sqls_config.yml"},
    on_attach = function(client)
        client.resolved_capabilities.execute_command = true
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
        require "sqls".setup {
            picker = "telescope"
        }
    end
}

nvim_lsp.pyright.setup {
    on_attach = on_attach
}

nvim_lsp.jsonls.setup {
    on_attach = on_attach
}

_G.goimports = function(timeoutms)
    local context = {source = {organizeImports = true}}
    vim.validate {context = {context, "t", true}}
    local params = vim.lsp.util.make_range_params()
    params.context = context

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
    if not result then
        return
    end

    for id, res in ipairs(result) do
        local client = vim.lsp.get_client_by_id(id)
        if client.name == "gopls" then
            local res_result = res.result
            if res_result then
                local edit = res_result[1].edit
                print(edit)
                vim.lsp.util.apply_workspace_edit(edit)
            end
        end
    end
end

vim.api.nvim_exec([[
autocmd BufWritePre *.go lua goimports(1000)
]], false)

local system_name
if vim.fn.has("mac") == 1 then
    system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
elseif vim.fn.has("win32") == 1 then
    system_name = "Windows"
else
    print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.expand("~/dotfiles/lsp/lua-language-server")
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

nvim_lsp.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = vim.split(package.path, ";")
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {"vim"}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                }
            }
        }
    }
}

-- bundle install --binstubs
local solargraph_path = "solargraph"
nvim_lsp.solargraph.setup {
    cmd = {solargraph_path, "stdio"},
    on_attach = on_attach
}

nvim_lsp.efm.setup {
    init_options = {documentFormatting = true, CodeAction = true},
    filetypes = {"ruby", "go", "markdown", "javascript", "lua", "yaml", "json", "sql"},
    on_attach = on_attach,
    root_dir = nvim_lsp.util.root_pattern(".git", vim.fn.getcwd())
}

local nvim_lsp_configs = require "lspconfig/configs"
if not nvim_lsp.tflint then
    nvim_lsp_configs.tflint = {
        default_config = {
            cmd = {"tflint", "--langserver"},
            filetypes = {"terraform"},
            root_dir = nvim_lsp.util.root_pattern(".terraform", ".git", ".tflint.hcl"),
            settings = {}
        }
    }
end
nvim_lsp.tflint.setup {
    on_attach = on_attach
}

-- Allow copy-paste from system clipboard
vim.api.nvim_command("set clipboard+=unnamedplus")

require("nlua.lsp.nvim").setup(
    nvim_lsp,
    {
        cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
        on_attach = on_attach,
        -- Include globals you want to tell the LSP are real :)
        globals = {
            -- Colorbuddy
            "Color",
            "c",
            "Group",
            "g",
            "s"
        }
    }
)

-- kyazdani42/nvim-tree.lua
vim.api.nvim_command("set termguicolors")
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", {noremap = true})
vim.api.nvim_command("highlight NvimTreeFolderIcon guibg=blue")
vim.api.nvim_set_var("nvim_tree_quit_on_open", 1)

-- nvim-treesitter/nvim-treesitter
require "nvim-treesitter.configs".setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true
    }
}

-- sainnhe/sonokai
vim.api.nvim_set_var("sonokai_style", "maia")
vim.api.nvim_command("colorscheme sonokai")

-- nvim-lspfuzzy
require("lspfuzzy").setup {}

-- completion-nvim
vim.api.nvim_command("set completeopt=menuone,noinsert,noselect")
vim.api.nvim_command("set shortmess+=c")
vim.api.nvim_set_var("completion_matching_strategy_list", {"exact", "substring", "fuzzy"})
vim.api.nvim_exec(
    [[
let g:completion_matching_ignore_case = 1
let g:completion_matching_smart_case = 1
let g:completion_enable_snippet = 'vim-vsnip'
]],
    false
)

-- https://github.com/nvim-lua/completion-nvim/wiki/chain-complete-support
vim.g.completion_chain_complete_list = {
    default = {
        {complete_items = {"lsp", "snippet"}},
        {complete_items = {"buffers"}},
        {mode = {"<c-p>"}},
        {mode = {"<c-n>"}}
    }
}
vim.api.nvim_exec(
    [[
autocmd BufEnter * lua require'completion'.on_attach()
let g:completion_auto_change_source = 1
]],
    false
)

vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

-- telescope
vim.api.nvim_set_keymap("n", "<C-p>", ":lua require('telescope.builtin').git_files()<cr>", {noremap = true})
vim.api.nvim_set_keymap(
    "n",
    "<C-b>",
    ":lua require('telescope.builtin').buffers({show_all_buffers=true})<cr>",
    {noremap = true}
)
vim.api.nvim_set_keymap("n", "<C-f>", ":lua require('telescope.builtin').live_grep()<cr>", {noremap = true})

-- Sensible undo
vim.api.nvim_command("set undolevels=5000")
vim.api.nvim_command("set undofile ")
vim.api.nvim_command("set undodir=~/.local/share/vim/undo//")
vim.api.nvim_command("set backupdir=~/.local/share/vim/backup//")
vim.api.nvim_command("set directory=~/.local/share/vim/swp//")

-- vim-numbertoggle
vim.api.nvim_command("set number relativenumber")

-- indentation
vim.api.nvim_exec([[
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
]], false)

-- hop
vim.api.nvim_set_keymap("n", "gf", "<cmd>lua require'hop'.hint_char1()<cr>", {})

-- https://vim.fandom.com/wiki/Automatically_quit_Vim_if_quickfix_window_is_the_last
vim.api.nvim_exec(
    [[
au BufEnter * call MyLastWindow()
function! MyLastWindow()
  " if the window is quickfix go on
  if &buftype=="quickfix"
    " if this window is last on screen quit without warning
    if winnr('$') < 2
      quit
    endif
  endif
endfunction
]],
    false
)

-- vim-vsnip
vim.api.nvim_exec(
    [[
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)
]],
    false
)

-- search
vim.api.nvim_exec(
    [[
set ignorecase
set hlsearch
set incsearch
set smartcase
set gdefault " s/<find>/<replace>/g -- g is auto-inserted.

" Find and replace (by Nick Janetakis)
nnoremap <Leader>rr :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>
xnoremap <Leader>rr :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" vim-asterisk / is-vim
let g:asterisk#keeppos = 1
map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)
]],
    false
)

-- lualine
local lualine = require("lualine")
lualine.setup {
    options = {theme = "auto"}
}

-- spell check
vim.api.nvim_exec(
    [[
set spelllang=en,cjk
nmap <silent> <leader>s :set spell!<CR> " Toggle spell checking on and off with `,s`
]],
    false
)

vim.api.nvim_exec([[
noremap <leader>pg :%!pg_format -L - <cr>
]], false)

-- gitsigns
require("gitsigns").setup()
