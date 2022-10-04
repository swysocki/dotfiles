local o = vim.opt
o.number = true
o.relativenumber = true
o.cursorline = true
o.foldenable = false
o.list = true

-- whitespace symbols
o.listchars = {
    tab = '▸ ',
    trail = '·',
    precedes = '←',
    extends = '→',
    eol = '↵'
}
o.updatetime = 300
o.swapfile = false

-- code folding
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldminlines = 15

-- diagnostic symbols
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = '▲'})
sign({name = 'DiagnosticSignHint', text = '⚑'})
sign({name = 'DiagnosticSignInfo', text = ''})

