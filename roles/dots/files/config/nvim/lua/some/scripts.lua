-- {"pylint", "flake8", "jedi", "pynvim"}

-- for httpie
function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function getPath(str)
    -- get dir path from file path
    -- /home/tmp/test/foo.json  -->  /home/tmp/test
    return str:match("(.*[/\\])")
end

function removeSpacesExceptQuotes(line)
    local result = ""
    local inQuotes = false

    for char in line:gmatch(".") do
        if char == '"' then
            inQuotes = not inQuotes
        end

        if char == " " and not inQuotes then
            -- Пропускаем пробел, если мы не внутри кавычек
        else
            result = result .. char
        end
    end

    return result
end

function close_window_with_response()
    local current_tab = vim.api.nvim_get_current_tabpage()
    local windows = vim.api.nvim_tabpage_list_wins(current_tab)

    if #windows > 1 then
        local windows = vim.api.nvim_list_wins()
        local current_window = vim.api.nvim_get_current_win()
        local prev_window = nil
        for _, win in ipairs(windows) do
            if win == current_window then
                vim.api.nvim_win_close(prev_window, true)
            else
                prev_window = win
            end
        end
    end
end

function rest()
    vim.api.nvim_command('w')

    local absolute_current_file = vim.api.nvim_buf_get_name(0)
    local absolute_current_dir = getPath(absolute_current_file)
    local neovim_open_path = vim.fn.getcwd()

    local file = io.open(absolute_current_file, 'rb')
    local count = 0
    local rest_command = ''
    local command = ''
    local json = ''

    for line in file:lines() do
        if count == 0 then
            command = line
        else
            line = removeSpacesExceptQuotes(line)
            if not string.starts(line, "#") then
                json = json .. line
            end
        end
        count = count + 1
    end

    local tmp_file = io.open('/tmp/nvim_request.json', 'w')
    io.output(tmp_file)
    io.write(json)
    io.close(tmp_file)

    local session_file = neovim_open_path .. '/' .. 'session'

    if string.starts(command, "http GET") then
        qparam = string.gsub(json, "{", "")
        qparam = qparam.gsub(qparam, "}", "")
        qparam = qparam.gsub(qparam, "'", "")
        qparam = qparam.gsub(qparam, "\"", '')
        -- qparam = qparam.gsub(qparam, ":", "==")
        -- qparam = qparam.gsub(qparam, "==", "==")
        qparam = qparam.gsub(qparam, ",", " ")
        rest_command = command .. " " .. qparam
    elseif string.starts(command, "http -f") then
        form_param = string.gsub(json, "{", "")
        form_param = form_param.gsub(form_param, "}", "")
        form_param = form_param.gsub(form_param, "'", "")
        form_param = form_param.gsub(form_param, ":", "=")
        form_param = form_param.gsub(form_param, ",", " ")
        rest_command = command .. " " .. form_param
    else
        rest_command = 'cat /tmp/nvim_request.json | ' .. command
    end

    local rest_command = rest_command .. ' --pretty format --print=hb --session=' .. session_file .. ' --timeout 8'
    print(rest_command)

    close_window_with_response()

    vim.cmd('vsplit')
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(win, buf)
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

    httpie_exec = io.popen(rest_command)
    http_result = {}

    for line in httpie_exec:lines() do
        table.insert(http_result, line)
    end

    vim.api.nvim_buf_set_option(buf, 'modifiable', true)
    vim.api.nvim_buf_set_lines(buf, 0, 0, true, http_result)
    vim.api.nvim_buf_set_option(buf, "ft", "http")

    file:close()
    httpie_exec:close()
    vim.cmd('wincmd w')

end


vim.api.nvim_create_user_command('R', rest, {})
vim.api.nvim_create_user_command('Json', '%!jq .', {})
vim.api.nvim_create_user_command('Test', close_window_with_response, {})

-- custom commands
vim.api.nvim_create_user_command('Gadd', 'Git add %', {})
vim.api.nvim_create_user_command('Gl', 'Git log -p %', {})
vim.api.nvim_create_user_command('Gd', 'Git diff %', {})
