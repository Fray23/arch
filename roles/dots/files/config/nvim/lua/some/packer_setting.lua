vim.g.everforest_background = 'hard'
-- vim.cmd('colorscheme everforest')
vim.cmd('colorscheme nord')
-- vim.cmd('colorscheme base16-black-metal')
-- vim.cmd('colorscheme doom-one')
-- vim.cmd('colorscheme dracula')
-- vim.cmd('colorscheme gruvbox')
-- vim.cmd('colorscheme onedark')
-- vim.cmd('colorscheme nightfox')
-- vim.cmd('colorscheme ayu-dark')
-- vim.cmd('set background=dark')

-- цвет номеров строк
vim.cmd('hi linenr guifg=white')
-- vim.cmd('hi linenr guifg=#D3C6AA')
-- telescope
local builtin = require('telescope.builtin')

-- fzf
vim.env.FZF_DEFAULT_OPTS = "--bind \"ctrl-n:preview-down,ctrl-p:preview-up\""
vim.keymap.set('n', '<leader>fl', ':Lines<CR>')

-- nerdtree
vim.cmd('autocmd FileType nerdtree setlocal relativenumber')
-- Open the existing NERDTree on each new tab.
vim.cmd("autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif")
-- Close the tab if NERDTree is the only window remaining in it.
vim.cmd("autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif")
-- Open the existing NERDTree on each new tab.

vim.g['NERDTreeShowHidden'] = 1
vim.g['NERDTreeWinSize'] = 50

-- lualine
vim.o.showtabline = 2
require('lualine').setup()

-- ale
vim.g.ale_echo_msg_format = '[%linter%] [%severity%] %code: %%s'
vim.g.ale_python_pylint_change_directory = 0
vim.g.ale_python_pylint_auto_pipenv = 1
vim.g.ale_python_flake8_change_directory=0
vim.g.ale_python_flake8_options = '--max-line-length=120'
vim.g.ale_python_mypy_change_directory=0
vim.g.ale_fix_on_save = 0
-- vim.g.ale_fixers = {"flake8"}
-- vim.g.ale_linters = {"flake8"}

-- # nvim-treesitter
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup({
    ensure_installed = {"python", "lua", "http", "json"},
    ignore_install = { "" }, -- List of parsers to ignore installing
    sync_install = true,
    auto_install = true,
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {}, -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
    },
    autopairs = {
        enable = true,
    },
    indent = { enable = true, disable = {} },
})

-- lsp-zero
local lsp = require('lsp-zero')
lsp.preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

lsp.nvim_workspace()
lsp.default_keymaps({
  buffer = bufnr,
})

local cmp = require('cmp')
local cmp_action = lsp.cmp_action()

cmp.setup({
  mapping = {
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
  }
})

lsp.setup()

-- startup
startup = require("startup") -- put theme name here
startup.setup({theme = "dashboard"})

-- hob
-- local hop = require('hop')
-- hop.setup()
-- local directions = require('hop.hint').HintDirection
-- vim.keymap.set('', 'f', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
-- end, {remap=true})
-- vim.keymap.set('', 'F', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
-- end, {remap=true})


-- auto pairs
-- Настройка символов, для которых будет автоматически вставляться закрывающая скобка
require('nvim-autopairs').setup{}

require("no-neck-pain").setup({ width = 150 })


-- harpoon
print(vim.api.nvim_win_get_width(0))
require("harpoon").setup({
    menu = {
        -- width = vim.api.nvim_win_get_width(0) - 4,
        width = 90
    }
})


require'mind'.setup()

-- ----------------------
-- SHORTCUTS
-- ----------------------

vim.keymap.set('n', '<leader>z', ':NoNeckPain<CR>')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('n', '<C-c>', '<esc>', { silent=true })

vim.keymap.set('n', '<C-n>', ':bn<CR>')
vim.keymap.set('n', '<C-p>', ':bp<CR>')

vim.keymap.set('v', 'p', 'P')
vim.keymap.set('n', '"', ':noh<CR>', { silent=true })

vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')

vim.keymap.set('n', '<C-S-k>', ':resize +5<cr>')
vim.keymap.set('n', '<C-S-j>', ':resize -5<cr>')
vim.keymap.set('n', '<S-K>', ':vertical resize -5<cr>')
vim.keymap.set('n', '<S-J>', ':vertical resize +5<cr>')

vim.keymap.set('n', '<C-y>', '<C-y>kzz')
vim.keymap.set('n', '<C-e>', '<C-e>jzz')

-- Mind
vim.keymap.set('n', '<leader>n', ':MindOpenProject<CR>')
vim.keymap.set('n', '<leader>c', ':MindClose<CR>')

-- telescope
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- nerdtree
vim.keymap.set('n', '>', ':tabn<cr>')
vim.keymap.set('n', '<', ':tabp<cr>')

vim.keymap.set('n', '<C-f>', ':NERDTreeFind<CR>')
-- vim.keymap.set('n', '<C-t>', ':tabdo NERDTreeToggle<CR>')
vim.keymap.set('n', '<C-t>', ':NERDTreeToggle<CR>')

-- tagbar
vim.keymap.set('n', 't', ':TagbarToggle<CR>')

-- harpoon
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-l>", '<cmd>lua require("harpoon.ui").nav_next()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-h>", '<cmd>lua require("harpoon.ui").nav_prev()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>1", '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>2", '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>3", '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>4", '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>5", '<cmd>lua require("harpoon.ui").nav_file(5)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>6", '<cmd>lua require("harpoon.ui").nav_file(6)<cr>', { noremap = true, silent = true })

