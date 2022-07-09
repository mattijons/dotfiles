local g = vim.g
local opt = vim.opt

opt.undofile = true
opt.swapfile = false

opt.splitright = true
opt.splitbelow = true

opt.ignorecase = true
opt.smartcase = true

opt.smarttab = true
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.list = true
-- TODO: make this work
-- opt.listchars = { tab = '›\\ ', trail = '•', extends = '#', nbsp = '.' }

opt.formatoptions = "cqj"

opt.number = true
opt.relativenumber = true

opt.cursorline = true

opt.termguicolors = true
opt.lazyredraw = true

opt.completeopt = {"menu", "menuone", "noselect"}

----------------------------------------------
-- GLOBALS
----------------------------------------------
g.python3_host_prog = "/usr/bin/python3"

-- Run make inside a docker container
vim.cmd [[
    let g:makery_config = {
    \   "~/dev/nanitor": {
    \     "make": {
    \       "makeprg": "docker exec --workdir /projects/nanitor nanitor_dev_env make"
    \     },
    \   }
    \ }
]]

-- Starify start screen
vim.cmd [[
  let g:startify_change_to_dir = 0
  let g:startify_change_to_vcs_root = 1
  let g:startify_custom_header=[
  \'                                                          ',
  \'    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗    ',
  \'    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║    ',
  \'    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║    ',
  \'    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║    ',
  \'    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║    ',
  \'    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝    ',
  \'                                                           ',
  \]
]]
----------------------------------------------
-- COMMANDS
----------------------------------------------
vim.cmd 'colorscheme tender'
