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
paq {"b3nj5m1n/kommentary"}
paq {"jiangmiao/auto-pairs"}

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

local nvim_lsp = require("lspconfig")
local on_attach = function(client, bufnr)
    require "completion".on_attach(client)

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

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
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
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
local servers = {}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {on_attach = on_attach}
end

nvim_lsp.tsserver.setup {
    cmd = {"typescript-language-server", "--stdio"},
    on_attach = on_attach
}

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
vim.api.nvim_set_var("ale_fixers", {lua = {"luafmt"}, javascript = {"prettier"}})
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
vim.api.nvim_set_var("completion_matching_strategy_list", {"exact", "substring", "fuzzy", "all"})
vim.api.nvim_set_var("completion_matching_smart_case", 1)

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
