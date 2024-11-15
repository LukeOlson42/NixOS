local lualine = require('lualine')

-- TODO: Make this look nicer and easier to add stuff

local config = {
    options = {
        icons_enabled = false,
        theme = 'sonokai',
        component_separators = '|',
        section_separators = '',
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {
            {
                'branch',
            },
        },
        lualine_c = {'filename'},
        lualine_x = {
            'encoding',
            'fileformat',
            'filetype',
            {
                'selectioncount',
                fmt =
                function(str)
                    local mode = vim.api.nvim_get_mode().mode
                    if str == '' then
                        return str
                    else
                        local plural = ''

                        if mode == 'V' then
                            local lines = tonumber(str)
                            if lines > 1 then plural = 's' end
                            return str .. ' line' .. plural
                        elseif mode == 'v' then
                            local chars = tonumber(str)
                            if chars > 1 then plural = 's' end
                            return str .. ' sel' .. plural
                        end

                        return 'Area: ' .. str -- default to visual block mode
                    end
                end
            },
        },
        lualine_y = {
            'progress',
        },
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    winbar = {},
    tabline = {},
    inactive_winbar = {},
    extensions = {}
}

local function insert_component(component)
    table.insert(config.sections.lualine_x, 1, component)
end

insert_component({
    -- Lsp server name .
    function()
        local msg = ''
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
})


lualine.setup(config)
