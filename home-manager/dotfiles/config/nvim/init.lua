require("config.lazy")
vim.lsp.enable('clangd')
vim.cmd("colorscheme zet")
vim.opt.clipboard = "unnamedplus"
vim.o.laststatus = 3

vim.opt.expandtab = true     
vim.opt.shiftwidth = 4      
vim.opt.tabstop = 4        
vim.opt.softtabstop = 4

vim.g.mapleader = " "
vim.wo.number = true

--vim.api.nvim_set_keymap('n', '<Esc>', ':q<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('i', '<Esc>', '<Esc>:q<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('v', '<Esc>', '<Esc>:q<CR>', { noremap = true, silent = true })

--vim.api.nvim_set_keymap('n', '<Esc>', ':confirm q<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('i', '<Esc>', '<Esc>:confirm q<CR>', { noremap = true, silent = true })

-- Completely disable Escape key in all modes
vim.api.nvim_set_keymap('n', '<Esc>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Esc>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Esc>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', '<Esc>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<Nop>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<F13>', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F13>', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<F13>', '<Esc>', { noremap = true, silent = true })

require("telescope").load_extension("session-lens")

require("telescope").setup({
  extensions = {
    ["session-lens"] = {
      path_display = { "shorten" },
      cwd_only = false,
      session_dir = "/home/z6/.config/nvim/sessions",
    },
  },
})


local map = vim.keymap.set
local opts = { noremap = true, silent = true }

require('lualine').setup {
  options = {
    theme = 'zet',  
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
}
 
local ls = require("luasnip")

map({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
map({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
map({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

map({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'find word' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', builtin.oldfiles, { desc = 'recently opened files' })

map('n', '<leader>n', ':Neotree toggle<CR>', opts)
map('n', '<leader>c', ':Neotree focus<CR>', opts)

map('n', '<leader>h', '<C-w>h', opts)
map('n', '<leader>j', '<C-w>j', opts)
map('n', '<leader>k', '<C-w>k', opts)
map('n', '<leader>l', '<C-w>l', opts)

map('n', '<C-s>', ':SessionSave<CR>', opts)
map('n', '<C-o>', ':Telescope session-lens search_session<CR>', opts)

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.completion.spell,
        require("none-ls.diagnostics.eslint") 
    }
})

local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},
        javascript = {'template_string'},
        java = false,
    }
})

local ts_conds = require('nvim-autopairs.ts-conds')

npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})

map('n', '<leader>ss', '<cmd>SessionSave<CR>', { desc = 'save <s>ession' })
map('n', '<leader>so', '<cmd>SessionRestore<CR>', { desc = 'session <o>pen' })
map('n', '<leader>sd', '<cmd>SessionDelete<CR>', { desc = 'session <d>elete' })
map('n', '<leader>sq', '<cmd>qa<CR>', { desc = 'session <q>uit' })
map('n', '<leader>sm', '<cmd>Telescope session-lens search_session<CR>', { desc = 'Browse Sessions' })

map('n', '<leader>sl', function()
  local session_dir = vim.fn.stdpath("config") .. "/sessions/"
  local sessions = vim.fn.glob(session_dir .. "*.vim", false, true)
  table.sort(sessions, function(a, b)
    return vim.fn.getftime(a) > vim.fn.getftime(b)
  end)
  if #sessions > 0 then
    vim.cmd("source " .. sessions[1])
    print("Loaded session: " .. vim.fn.fnamemodify(sessions[1], ":t"))
  else
    print("No sessions found.")
  end
end, { desc = '[S]ession [L]ast' })

require("auto-session").setup({
  session_dir = "/home/z6/.config/nvim/sessions", 
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = true,
  auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
})

_G.load_last_session = function()
  local session_dir = "/home/z6/nvim/sessions/"
  local sessions = vim.fn.glob(session_dir .. "*.vim", false, true)

  table.sort(sessions, function(a, b)
    return vim.fn.getftime(a) > vim.fn.getftime(b)
  end)

  if #sessions > 0 then
    vim.cmd("source " .. sessions[1])
    vim.notify("Loaded session: " .. vim.fn.fnamemodify(sessions[1], ":t"), vim.log.levels.INFO)
  else
    vim.notify("No sessions found.", vim.log.levels.WARN)
  end
end

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
		"                        ███                 ",
		"                       ░░░                  ",
		" █████████ █████ █████ ████  █████████████  ",
		"░█░░░░███ ░░███ ░░███ ░░███ ░░███░░███░░███ ",
		"░   ███░   ░███  ░███  ░███  ░███ ░███ ░███ ",
		"  ███░   █ ░░███ ███   ░███  ░███ ░███ ░███ ",
		 " █████████  ░░█████    █████ █████░███ █████",
		"░░░░░░░░░    ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░ ",
        "                                            ",
        "                                            ",
}

dashboard.section.buttons.val = {
  dashboard.button("Space  e", "  New file", ":ene <BAR> startinsert<CR>"),
  dashboard.button("Space ff", "󰈞  Find file", ":Telescope find_files<CR>"),
  dashboard.button("Space fh", "󰊄  Recently opened files", ":Telescope oldfiles<CR>"),
  dashboard.button("Space fg", "󰈬  Find word", ":Telescope live_grep<CR>"),
  dashboard.button("Space sm", "  Browse Sessions", ":Telescope session-lens search_session<CR>"),
  dashboard.button("Space sl", "  Open last session", ":lua load_last_session()<CR>")
}

dashboard.config.layout = {
  dashboard.section.header,
  dashboard.section.buttons,
  dashboard.section.footer,
}

alpha.setup(dashboard.config)

