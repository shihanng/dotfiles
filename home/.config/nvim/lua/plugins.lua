vim.cmd "packadd paq-nvim" -- Load package
local paq = require "paq-nvim".paq -- Import module and bind `paq` function
paq {"savq/paq-nvim", opt = true} -- Let Paq manage itself
paq {"neovim/nvim-lspconfig"}
paq {"dense-analysis/ale"}
paq {"tpope/vim-surround"}
paq {"tjdevries/nlua.nvim"}
paq {"kyazdani42/nvim-web-devicons"}
paq {"kyazdani42/nvim-tree.lua"}
paq {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
paq {"sainnhe/sonokai"}
paq {"nvim-lua/completion-nvim"}
paq {"steelsojka/completion-buffers"}
paq {"nvim-treesitter/completion-treesitter"}

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

paq {"nathunsmitty/nvim-ale-diagnostic"}
paq {"jeffkreeftmeijer/vim-numbertoggle"}

paq {"jparise/vim-graphql"}
paq {"onsails/lspkind-nvim"}

paq {"hrsh7th/vim-vsnip"}
paq {"hrsh7th/vim-vsnip-integ"}

paq {"direnv/direnv.vim"}

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
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    buf_set_keymap("n", "ga", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        vim.api.nvim_exec(
            [[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
         augroup END
         ]],
            true
        )
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
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

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {"graphql"}
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
    on_attach = function(client)
        -- Because we are using GOIMPORTS
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
    end
}

function GOIMPORTS(timeoutms)
    local context = {source = {organizeImports = true}}
    vim.validate {context = {context, "t", true}}

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
    if not result or next(result) == nil then
        return
    end
    local actions = result[1].result
    if not actions then
        return
    end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
        if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit)
        end
        if type(action.command) == "table" then
            vim.lsp.buf.execute_command(action.command)
        end
    else
        vim.lsp.buf.execute_command(action)
    end
end

vim.api.nvim_exec([[
autocmd BufWritePre *.go lua GOIMPORTS(1000)
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

-- ALE
vim.api.nvim_set_var("ale_linters_explicit", 1)
vim.api.nvim_set_var("ale_disable_lsp", 1)
vim.api.nvim_set_var("ale_sign_column_always", 1)
vim.api.nvim_set_var("ale_fixers", {lua = {"luafmt"}, javascript = {"prettier"}, json = {"prettier"}})
vim.api.nvim_set_var("ale_fix_on_save", 1)
vim.api.nvim_set_var("ale_lua_luafmt_executable", "luafmt")
vim.api.nvim_exec(
    [[
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)
]],
    false
)

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

-- nvim-ale-diagnostic
-- Routes Neovim LSP diagnostics to ALE for display.
require("nvim-ale-diagnostic")
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = false,
        virtual_text = false,
        signs = true,
        update_in_insert = false
    }
)

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
]],
    false
)
