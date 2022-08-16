local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>8", "<cmd>lua RELOAD('scratchpad').do_something()<CR>", {})
keymap("n", "<leader>9", "<cmd>lua RELOAD('scratchpad').run()<CR>", {})
keymap("n", "<leader>ft", "<cmd>Telescope help_tags<CR>", {})

local M = {}

local TEMPLATE_DIR = "$HOME/git/public/scratchpad.nvim/templates"

M._current_compile_line = "default"

M.do_something = function()
    if vim.bo.filetype == "cpp" then
        vim.api.nvim_command('tabe ' .. TEMPLATE_DIR .. '/cpp.cpp')
    else
        print(string.format("The filetype %s is not supported", vim.bo.filetype))
    end
end

M.run = function()
    local buf_nr = vim.api.nvim_get_current_buf()
    local compile_line = vim.api.nvim_buf_get_lines(buf_nr, 0, 1, false)
    M.current_compile_line = string.sub(compile_line[1], 4, #compile_line[1])
    vim.api.nvim_set_current_dir(TEMPLATE_DIR)

    vim.cmd("vert split term://zsh -c " .. "cd " .. TEMPLATE_DIR .. " && " .. M.current_compile_line)

    vim.api.nvim_create_autocmd({"BufLeave"}, {
        pattern = { "*" },
        once = true,
        callback = function()
            vim.api.nvim_buf_delete(0, {})
        end
    })


end

return M












