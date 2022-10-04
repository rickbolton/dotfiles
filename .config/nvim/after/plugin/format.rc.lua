local cmd = vim.cmd

cmd [[
    augroup VueFmt
        autocmd!
        autocmd BufWritePre *.vue lua vim.lsp.buf.formatting_sync(nil, 1000)
    augroup END
]]

