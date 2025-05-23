-- FIX:
-- Mason ugrade to version v2 has breaking changes. I pin to the version
-- v1, till poriting cleanly to v2.
-- See: https://github.com/LazyVim/LazyVim/issues/6039
return {
    { "mason-org/mason.nvim", version = "^1.0.0" },
    { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
}
