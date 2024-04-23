vim.o.background = 'light' -- 'dark' or 'light'
vim.g.everforest_background = 'hard'
-- vim.cmd('colorscheme everforest')
-- vim.cmd('colorscheme nord')
-- vim.cmd('colorscheme base16-black-metal')
-- vim.cmd('colorscheme doom-one')
-- vim.cmd('colorscheme dracula')
-- vim.cmd('colorscheme onedark')
-- vim.cmd('colorscheme nightfox')
-- vim.cmd('colorscheme Tomorrow-Night-Bright')
-- vim.cmd('colorscheme doom-one')
vim.cmd('colorscheme dracula-soft')
-- vim.cmd('colorscheme solarized')
-- vim.cmd('colorscheme gruvbox')
-- vim.cmd('colorscheme lake')
-- vim.cmd('highlight Normal guibg=#000000 ctermbg=black')
vim.api.nvim_set_hl(0, 'CursorLine', { underline = true })

-- цвет номеров строк
-- vim.cmd('hi linenr guifg=white')
-- vim.cmd('hi linenr guifg=#D3C6AA')
-- telescope
local builtin = require('telescope.builtin')

-- lualine
vim.o.showtabline = 2
require('lualine').setup()

-- nerdtree
vim.cmd('autocmd FileType nerdtree setlocal relativenumber')
-- Open the existing NERDTree on each new tab.
vim.cmd("autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif")
-- Close the tab if NERDTree is the only window remaining in it.
vim.cmd("autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif")
-- Open the existing NERDTree on each new tab.

vim.g['NERDTreeShowHidden'] = 1
vim.g['NERDTreeWinSize'] = 50


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


-- hob
local hop = require('hop')
hop.setup()
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, {remap=true})

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

-- ----------------------
-- lsp
-- ----------------------
local lsp_zero = require('lsp-zero')
lsp_zero.preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})


lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)


-- cmp
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format({details = true})

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
  },
  mapping = cmp.mapping.preset.insert({
    ['<cr>'] = cmp.mapping.confirm({select = true}),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  formatting = cmp_format,
})


-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

-- ----------------------
-- Syntax CHeck
-- ----------------------
vim.g.ale_echo_msg_error_str = 'E'
vim.g.ale_echo_msg_warning_str = 'W'
vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'

-- ----------------------
-- SHORTCUTS
-- ----------------------
vim.keymap.set('n','y','"+y')
vim.keymap.set('n','yy','"+yy')
vim.keymap.set('n','Y','"+Y')
vim.keymap.set('x','y','"+y')
vim.keymap.set('x','Y','"+Y')

vim.api.nvim_set_keymap('n', '<Space>v', 'p', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<Space>v', '<Esc>pa', { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', '<Space>v', '<C-r>"<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<Space>cc', ':NoNeckPain<CR>')

vim.keymap.set('n', '<M-d>', '<C-d>zz')
vim.keymap.set('n', '<M-u>', '<C-u>zz')
vim.keymap.set('n', '<M-y>', '<C-y>kzz')
vim.keymap.set('n', '<M-e>', '<C-e>jzz')

vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('n', '<M-c>', '<esc>', { silent=true })

vim.keymap.set('n', '<C-n>', ':bn<CR>')
vim.keymap.set('n', '<C-p>', ':bp<CR>')

vim.keymap.set('v', 'p', 'P')
vim.keymap.set('n', '"', ':noh<CR>', { silent=true })

vim.keymap.set('n', '<S-j>', ':vertical resize +5<cr>')
vim.keymap.set('n', '<S-k>', ':vertical resize -5<cr>')
vim.keymap.set('n', '<S-h>', ':resize +5<cr>')
vim.keymap.set('n', '<S-l>', ':resize -5<cr>')

vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')

vim.keymap.set('n', '<Space>ll', 'zz')

vim.keymap.set('n', '<C-g>', '<esc>')
vim.keymap.set('i', '<C-g>', '<esc>')
vim.keymap.set('v', '<C-g>', '<esc>')

-- nerd tree
vim.keymap.set('n', '<C-f>', ':NERDTreeFind<CR>')
vim.keymap.set('n', '<C-t>', ':NERDTreeToggle<CR>')

-- save
vim.keymap.set('n', '<Space>8', ':w<CR>')
vim.keymap.set('n', '<Space>2', ':q<CR>')
-- exit without save
vim.keymap.set('n', '<Space>6', ':q!<CR>')

-- copy
vim.api.nvim_set_keymap('n', '<Space>vl', ':normal!_v$y <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<CR>', 'y', {})

-- move
vim.keymap.set('n', '<Space>7', '_')
vim.keymap.set('n', '<Space>9', '$')

vim.keymap.set('v', '<Space>7', '_')
vim.keymap.set('v', '<Space>9', '$h')

vim.keymap.set('n', '.', '<C-d>zz<CR>')
vim.keymap.set('n', ',', '<C-u>zz<CR>')

vim.keymap.set('v', '.', '<C-d>zz<CR>')
vim.keymap.set('v', ',', '<C-u>zz<CR>')

-- split
vim.keymap.set('n', '<Space>sh', ':vs<CR>')
vim.keymap.set('n', '<Space>sv', ':sp<CR>')

-- telescope
vim.keymap.set('n', '<Space><Space>', builtin.find_files, {})
vim.keymap.set('n', '<Space>pg', builtin.live_grep, {})
vim.keymap.set('n', '<Space>bb', builtin.buffers, {})
vim.keymap.set('n', '<Space>m', builtin.marks, {})

-- harpoon
vim.api.nvim_set_keymap("n", "<Space>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>hl", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Space>hn", '<cmd>lua require("harpoon.ui").nav_next()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>hp", '<cmd>lua require("harpoon.ui").nav_prev()<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Space>h1", '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>h2", '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>h3", '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>h4", '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>h5", '<cmd>lua require("harpoon.ui").nav_file(5)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>h6", '<cmd>lua require("harpoon.ui").nav_file(6)<cr>', { noremap = true, silent = true })
