return {
    -- use based-pyright for hover/hints/typecheck/etc. and code actions
    on_attach = function(client, _)
        client.server_capabilities.completionProvider        = true -- pyrefly
        client.server_capabilities.definitionProvider        = true -- pyrefly
        client.server_capabilities.documentHighlightProvider = true -- pyrefly
        client.server_capabilities.renameProvider            = true -- pyrefly
        client.server_capabilities.semanticTokensProvider    = true -- pyrefly
    end,
    settings = {
        basedpyright = {
            disableOrganizeImports = true, -- ruff
            analysis = {
                typeCheckingMode = "basic",
                diagnosticSeverityOverrides = {
                    reportUnusedVariable = "none", -- ruff
                    reportUnusedImport = "none", -- ruff
                },
            },
        },
    },
}

