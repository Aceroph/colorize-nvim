local M = {}

local highlight_groups = {}

function M.setup(opts)
    local opts = opts or {}

    M.colorize()
end

function M.colorize()
    local height = vim.api.nvim_win_get_height(0)
    local startline = vim.api.nvim_win_get_cursor(0)[0] - 1

    local regex_hex = vim.regex([[\c0x[0-9a-f]{3}([0-9a-f]{3}([0-9a-f]{2})?)?]])
    local regex_str_hex = vim.regex([[\c#[0-9a-f]{3}([0-9a-f]{3}([0-9a-f]{2})?)?]])
    local regex_rgb = vim.regex([[\crgba?\([0-9]{1,3}, ?[0-9]{1,3}, ?[0-9]{1,3}(, ?[0-9]{1,3})?\)]])

    for i, line in ipairs(vim.api.nvim_buf_get_lines(0, startline, startline + height, false)) do
        local hex_match = regex_hex:match_str(line)
        for starti, endi in hex_match do
            local content = string.sub(line, starti, endi)
            local hl_idx = vim.api.nvim_set_hl(0, "Colorize" .. content, { bg = "#ffffff", fg = "#000000" })
            vim.fn.matchadd("Colorize" .. content, content)
            table.insert(highlight_groups, hl_idx)
        end
    end
end

return M
