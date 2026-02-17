return {
    -- use ruff for formatting, linting, and code actions
    on_attach = function(client, _)
        client.server_capabilities.hoverProvider                   = true -- basedpyright conflict?
    end,
    -- init_options = {
    --     settings = {
    --         lint = {
    --             ignore = {"F841"},
    --         },
    --     },
    -- },
}

