return {
    {
        "dmtrKovalenko/fff.nvim",
        build = function() require("fff.download").download_or_build_binary() end,
        lazy = false, -- the plugin lazy-initialises itself
        opts = {},
    },
    {
        "madmaxieee/fff-snacks.nvim",
        lazy = false, -- lazy loaded by design
        dependencies = { "dmtrKovalenko/fff.nvim", "folke/snacks.nvim" },
        opts = {},
    },
}
