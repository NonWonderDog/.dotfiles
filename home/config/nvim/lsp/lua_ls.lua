return {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
            },
            telemetry = { enable = false },
            diagnostics = { globals = { 'vim', 'require' } },
        },
    },
}
