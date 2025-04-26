vim.filetype.add({
    extension = {
        astro = "astro",

        hcl = "terraform",
    },
    filename = {},
    pattern = {
        [".*/ansible/.*%.yml"] = "yaml.ansible",

        [".*/%.github[%w/]+workflows[%w/]+.*%.ya?ml"] = "yaml.github",
    },
})
