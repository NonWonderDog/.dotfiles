return {
    -- use pyrefly for completions/definitions/rename/etc.
    on_attach = function(client, _)
        client.server_capabilities.codeActionProvider        = false -- basedpyright, ruff
        client.server_capabilities.documentSymbolProvider    = false -- basedpyright
        client.server_capabilities.hoverProvider             = false -- basedpyright
        client.server_capabilities.inlayHintProvider         = false -- basedpyright
        client.server_capabilities.referenceProvider         = false -- basedpyright
        client.server_capabilities.signatureHelpProvider     = false -- basedpyright
    end,
    settings = {
        pyrefly = {
            errors = {
                ["unused-variable"] = false, -- ruff -- this doesn't work???
            },
        },
    },
}
