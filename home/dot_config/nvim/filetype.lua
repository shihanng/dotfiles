vim.filetype.add({
    extension = {
        mdx = "markdown.mdx",
        astro = "astro",
        hcl = "terraform",
    },
    filename = {},
    pattern = {
        [".*/ansible/.*%.yml"] = "yaml.ansible",
    },
})
