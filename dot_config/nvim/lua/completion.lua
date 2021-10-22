vim.opt.completeopt = {"menuone", "noselect"}

vim.opt.shortmess:append {c = true}

local cmp = require "cmp"

cmp.setup(
    {
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            end
        },
        mapping = {
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm({select = true})
        },
        sources = cmp.config.sources(
            {
                {name = "nvim_lsp"},
                {name = "vsnip"}, -- For vsnip users.
                {name = "path"},
                {name = "buffer"},
                {name = "nvim_lua"}
            }
        )
    }
)
