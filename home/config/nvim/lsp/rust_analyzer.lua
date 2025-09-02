return {
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            },
            rustfmt = {
                extraArgs = { "+nightly" },
            },
        },
        rustfmt = {
            rangeFormatting = { enable = true },
        },
    },
}
