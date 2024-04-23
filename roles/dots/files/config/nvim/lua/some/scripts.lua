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

function close_window_with_response()
    local current_tab = vim.api.nvim_get_current_tabpage()
    local windows = vim.api.nvim_tabpage_list_wins(current_tab)

    if #windows > 1 then
        local current_window = vim.api.nvim_get_current_win()
        local prev_window = nil
        for i = #windows, 1, -1 do
            local win = windows[i]
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
    local neovim_open_path = vim.fn.getcwd()

    local pyhttp = 'python ~/bin/easy_http.py ' .. absolute_current_file .. ' ' .. neovim_open_path
    pyhttp_exec = io.popen(pyhttp)

    close_window_with_response()

    local win = vim.api.nvim_get_current_win()
    local current_buf = vim.api.nvim_get_current_buf()
    vim.cmd('vsplit')
    local buf = vim.api.nvim_create_buf(true, true)


    vim.api.nvim_win_set_buf(win, buf)
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

    http_result = {}

    for line in pyhttp_exec:lines() do
        table.insert(http_result, line)
    end

    pyhttp_exec.close()

    vim.api.nvim_buf_set_option(buf, 'modifiable', true)
    vim.api.nvim_buf_set_lines(buf, 0, 0, true, http_result)
    vim.api.nvim_buf_set_option(buf, "ft", "http")
    vim.api.nvim_buf_set_option(current_buf, "ft", "http")
end

vim.cmd("au! BufRead,BufNewFile *.http setfiletype http")

vim.api.nvim_set_keymap('v', '<Space>j', ':\'<,\'>!jq . <CR>', { noremap = true, silent = true })

vim.api.nvim_create_user_command('Test', close_window_with_response, {})

vim.api.nvim_create_user_command('R', rest, {})
vim.api.nvim_set_keymap("n", "<Space>rs", ':R<CR>', { noremap = true, silent = true })

-- custom commands
vim.api.nvim_create_user_command('Ga', 'Git add %', {})
vim.api.nvim_create_user_command('Gl', 'Git log -p %', {})
vim.api.nvim_create_user_command('Gd', 'Git diff %', {})
