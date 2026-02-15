vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set("n","u","<Cmd>call VSCodeNotify('undo')<CR>")
vim.keymap.set("n","<C-r>","<Cmd>call VSCodeNotify('redo')<CR>") 
vim.keymap.set("n", "m", "<Cmd>call VSCodeNotify('bookmarks.toggle')<CR>")

-- Unbind the normal 'm' key
vim.keymap.set('n', 'm', '<NOP>', { noremap = true, silent = true })

vim.keymap.set('n', 'mm', "<Cmd>call VSCodeNotify('bookmarks.toggle')<CR>", { noremap = true, silent = true })
vim.keymap.set('n', 'ml', "<Cmd>call VSCodeNotify('bookmarks.list')<CR>", { noremap = true, silent = true })
vim.keymap.set('n', 'm,', "<Cmd>call VSCodeNotify('bookmarks.jumpToPrevious')<CR>", { noremap = true, silent = true })
vim.keymap.set('n', 'm.', "<Cmd>call VSCodeNotify('bookmarks.jumpToNext')<CR>", { noremap = true, silent = true })

