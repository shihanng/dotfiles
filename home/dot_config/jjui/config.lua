function setup(config)
    -- Remap q to ctrl+c to quit.
    config.action("no-op", function() end, { desc = "Do nothing" })
    local scopes = { "ui", "revisions", "revisions.evolog", "git", "bookmarks", "oplog", "diff" }
    for _, scope in ipairs(scopes) do
        config.bind({
            action = "no-op",
            key = "q",
            scope = scope,
        })
        config.bind({
            action = "ui.quit",
            key = "ctrl+c",
            scope = scope,
        })
    end

    config.action("copy-file-path", function()
        local file = context.file()
        copy_to_clipboard(file)
        flash("Copied: " .. file)
    end, { desc = "Copy file path", key = "ctrl+o", scope = "revisions.details" })
end
