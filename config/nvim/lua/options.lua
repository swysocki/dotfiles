local o = vim.opt
o.number = true
o.cursorline = true
o.list = true
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
