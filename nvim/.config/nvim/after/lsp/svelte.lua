return {
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            callback = function(ctx)
                client.notify("$/onDidChangeTsOrJsFile", { uri = vim.uri_from_fname(ctx.match) })
            end,
        })
    end,
}
