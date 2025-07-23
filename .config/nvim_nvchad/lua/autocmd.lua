local autocmd = vim.api.nvim_create_autocmd

-- Disable autocomments new line
autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove { "r", "o" }
  end,
})

-- Delete trailing whitespaces before save file
-- autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function()
--     local save_cursor = vim.fn.getpos "."
--     vim.cmd [[%s/\s\+$//e]]
--     vim.fn.setpos(".", save_cursor)
--   end,
-- })

-- Indentation for C and C++
autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end,
})

-- Indentation for Groovy
autocmd("FileType", {
  pattern = "groovy",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end,
})

-- Indentation for Makefiles
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.bo.tabstop = 8
    vim.bo.shiftwidth = 8
    vim.bo.expandtab = false
  end,
})

-- Indentation for Bash
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
})
