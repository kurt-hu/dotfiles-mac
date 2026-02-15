-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- vim.api.nvim_create_autocmd('BufEnter', {
--   pattern = '*',
--   callback = function()
--     vim.cmd 'TSBufEnable highlight'
--   end,
-- })

-- Override Flash.nvim's <CR> mapping in quickfix windows
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	desc = "Use default <CR> behavior in quickfix",
	group = vim.api.nvim_create_augroup("quickfix-enter", { clear = true }),
	callback = function()
		vim.keymap.set("n", "<CR>", "<CR>", { buffer = true, desc = "Jump to quickfix entry" })
	end,
})

-- in your Neovim config (e.g., after gitsigns setup)
-- vim.api.nvim_create_autocmd("TermOpen", {
-- 	pattern = "*",
-- 	callback = function(args)
-- 		local bufname = vim.api.nvim_buf_get_name(args.buf)
-- 		if bufname:match("lazygit") then
-- 			pcall(function()
-- 				require("gitsigns").detach()
-- 			end)
-- 		end
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("TermClose", {
-- 	pattern = "*",
-- 	callback = function(args)
-- 		local bufname = vim.api.nvim_buf_get_name(args.buf)
-- 		if bufname:match("lazygit") then
-- 			pcall(function()
-- 				require("gitsigns").attach()
-- 			end)
-- 		end
-- 	end,
-- })
