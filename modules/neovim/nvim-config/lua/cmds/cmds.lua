local new_command = vim.api.nvim_create_user_command

new_command("Clean",
    function()
        local r,c = unpack(vim.api.nvim_win_get_cursor(0))
        print("Clearing background buffers...")
        vim.cmd("%bd|e#|bd#")
        vim.api.nvim_win_set_cursor(0, {r,c}) -- now we go back to where we were before
    end,
    {
        nargs = 0
    }
)

--[[
new_command("Build", -- TODO: slide this bad boy into a local plugin :O
    function(opts)
        local args = string.gmatch(opts.args, "%S+")
        local f = io.open('BuildConfigList.txt', "rb")
        local bestMatch = ''

        if f then -- if no buildconfiglist, just go into [Bb]uild/ and run make
            local content = f:read "*a"
            f:close()

            content = content:gsub("%s+", "\n")
            local matches = {}
            for line in string.gmatch(content, "([^\n]+)") do
                table.insert(matches, line)
            end

            for arg in args do
                local tempMatches = {}
                local keyword = arg

                for _,cfg in pairs(matches) do
                    if cfg:find(string.upper(keyword)) then
                        table.insert(tempMatches, cfg)
                    end
                end

                matches = {}
                for k,v in pairs(tempMatches) do
                    matches[k] = v
                end
            end

            bestMatch = matches[1]
        else
            bestMatch = ''
        end

        if bestMatch == nil then
            print('Failed to find configuration!')
            return nil
        end

        local cdCmd = "cd Build/" .. bestMatch .. "\r\n"  -- cd to first match

        vim.api.nvim_command('vsplit new')
        local buf_handle = vim.api.nvim_win_get_buf(0)
        local jobID = vim.api.nvim_call_function("termopen", {"cmd"})
        vim.api.nvim_buf_set_option(buf_handle, 'modifiable', true)
        vim.api.nvim_buf_set_lines(buf_handle, 0, 0, true, {"ls"})
        vim.api.nvim_chan_send(jobID, cdCmd)

        if opts.bang then
            vim.api.nvim_chan_send(jobID, "mingw32-make clean && mingw32-make\r\n") -- UPDATE WITH NEW OS!!!! MAKE PLATFORM AGNOSTIC!!!!
        else
            vim.api.nvim_chan_send(jobID, "mingw32-make\r\n")
        end
    end,
    {
        nargs = '*',
        bang = true,
    }
)
]]--


new_command("Header",
    function()
        print("Generating header from filename...")
        local filename = string.gsub(vim.api.nvim_buf_get_name(0), vim.loop.cwd(), '')

        filename = filename:match("[^/\\]*.h$")

        if(filename == nil)
        then
            print("Invalid Filename! Must have extension .h")
            return nil
        end

        local headerPrep = string.upper(filename)
        headerPrep = string.gsub(headerPrep, '%.', '_') .. '_'

        local headerTop = '/*****************************************************************************************************************'
        local headerBot = '*****************************************************************************************************************/'

        local includeFilesHeader = ' *                  Include Files'
        local definesHeader      = ' *                  Defines'
        local funcSigHeader      = ' *                  Function Signatures'
        local funcDecHeader      = ' *                  Function Declaration'
        local eofHeader          = ' *                  End of File'

        vim.api.nvim_buf_set_lines(0, 0, 30, false, {'#ifndef ' .. headerPrep, '#define ' .. headerPrep,
                                                    headerTop, includeFilesHeader, headerBot, '',
                                                    headerTop, definesHeader, headerBot, '',
                                                    headerTop, funcSigHeader, headerBot, '',
                                                    headerTop, funcDecHeader, headerBot, '',
                                                    headerTop, eofHeader, headerBot,
                                                    '#endif'})
    end,
    {}
)


new_command("Switch",
    function(opts)
        vim.cmd(string.format("!git switch %s", opts.fargs[1]))
    end,
    {
        nargs = 1,
    }
)
