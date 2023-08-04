vim.opt.number = true
vim.opt.relativenumber = true

vim.cmd.colorscheme('photon')

vim.opt.foldmethod='indent'
vim.opt.foldlevelstart=99

vim.cmd.filetype("plugin indent on")

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<CR>', ':let @/=""<CR>')
vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('t', 'jk', '<C-\\><C-n>')
vim.keymap.set('n', '<S-s>', ':split<CR>')

vim.keymap.set('t', '<M-d>', 'pwd|xclip -selection clipboard<CR><C-\\><C-n>:cd <C-r>+<CR>i') 

vim.opt.tabstop = 8
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true

vim.opt.laststatus = 2
vim.opt.statusline = "%f%=%m %P %{strftime(\"%H:%M\")}"

vim.api.nvim_create_autocmd('TermOpen', { pattern = '*', command = 'set nonumber norelativenumber' })
vim.api.nvim_create_autocmd('Filetype', { pattern = 'rust', command = 'source ~/.config/nvim/rust.lua' })

function term_run(cmd)
    vim.cmd('FloatermToggle')
    vim.cmd('FloatermShow')
    local real_cmd = cmd .. vim.api.nvim_replace_termcodes('<CR><ESC>', true, false, true)
    vim.api.nvim_feedkeys(real_cmd, 'n', true)
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    "machakann/vim-sandwich",
    "voldikss/vim-floaterm",
    "tpope/vim-commentary",
    "christoomey/vim-system-copy",
    "lervag/vimtex",
    "junegunn/fzf",
    "junegunn/fzf.vim",
    "neovim/nvim-lspconfig",
    "whonore/Coqtail",
    "ggandor/leap.nvim",
    "github/copilot.vim",
    "scalameta/nvim-metals",
    "nvim-lua/plenary.nvim",
    "williamboman/mason.nvim",
    'simrat39/rust-tools.nvim'
}

require("lazy").setup(plugins)

vim.g.floaterm_height = 0.9
vim.g.floaterm_width = 0.8
vim.keymap.set('n', '<C-b>', ':FloatermToggle<CR>')
vim.keymap.set('t', '<C-b>', '<C-\\><C-n>:FloatermToggle<CR>')
vim.opt.hidden = true

vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'

vim.keymap.set('n', '<S-p>', ':Rg<CR>')
vim.keymap.set('n', '<C-p>', ':GFiles<CR>')

vim.keymap.set('n', 'sa', '<Plug>(operator-sandwich-add)')
vim.keymap.set('n', 'sd', '<Plug>(operator-sandwich-delete)')
vim.keymap.set('n', 'sr', '<Plug>(operator-sandwich-replace)')

require('mason').setup()

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)

local rt = require('rust-tools')
rt.setup({
    server = {
        on_attach = function(client, bufnr)
            vim.keymap.set('n', 'K', rt.hover_actions.hover_actions, {buffer = bufnr})
        end
    },

    inlay_hints = {
        auto = true,
    },

    hover_actions = {

      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },

      -- Maximal width of the hover window. Nil means no max.
      max_width = nil,

      -- Maximal height of the hover window. Nil means no max.
      max_height = nil,

      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = true,
    },
})
