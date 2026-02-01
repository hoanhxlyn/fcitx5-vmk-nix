function()
    local MiniFiles = require('mini.files')
    local ok = pcall(MiniFiles.open, vim.api.nvim_buf_get_name(0), false)
    if not ok then
        MiniFiles.open(nil, false)
    end
end
