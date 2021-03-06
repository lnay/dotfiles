"dein Scripts-----------------------------

" Required:
set runtimepath+=/home/luke/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/home/luke/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('/home/luke/.cache/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
call dein#add('nvim-treesitter/nvim-treesitter')
call dein#add('neovim/nvim-lspconfig')
call dein#add('lervag/vimtex')
call dein#add('mattn/emmet-vim')
call dein#add('mhartington/oceanic-next')
call dein#add('nvim-lua/plenary.nvim') "some sort of lua library
call dein#add('lewis6991/gitsigns.nvim')
call dein#add('lukas-reineke/indent-blankline.nvim')
call dein#add('nvim-lualine/lualine.nvim')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-fugitive')
call dein#add('hrsh7th/nvim-cmp')
call dein#add('hrsh7th/cmp-nvim-lsp')
call dein#add('hrsh7th/cmp-path')
call dein#add('saadparwaiz1/cmp_luasnip')
call dein#add('L3MON4D3/LuaSnip')
call dein#add('rafamadriz/friendly-snippets')

call dein#add('mfussenegger/nvim-dap')
call dein#add('Pocco81/DAPInstall.nvim', {'rev' : '24923c3819'})
" Required:
call dein#end()

" Required:
filetype plugin indent on

" PLUGIN CONFIGS
let g:indent_blankline_enabled = v:false
let g:indent_blankline_space_char = '·'
let g:indent_blankline_char='┆'
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_current_context = v:true

let g:tex_flavor = 'latex'
let g:vimtex_complete_enabled=0
lua <<EOF
require('gitsigns').setup()
require('lualine').setup {
	options = { theme = 'papercolor_dark'}
}
EOF

"End dein Scripts-------------------------

" TREESITTER CONFIGS
" ========== =======

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

" LSP CONFIGS
" === =======

lua<<EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {"texlab","denols","cssls","dockerls", "hls","svelte","rust_analyzer"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip/loaders/from_vscode").load() -- required to load the snippets from "friendly-snippets" plugin

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable() then
        luasnip.jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

-- dapinstall setup
dap_install = require("dap-install")

dap_install.setup({
	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
})

dap_install.config("python", {})
vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='❓', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='❗', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⏸', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='✏️', texthl='', linehl='', numhl=''})
EOF
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

set number
set relativenumber
set mouse=a
set tabstop=4
set shiftwidth=4
set noexpandtab
set inccommand=nosplit
set laststatus=3

if (has("termguicolors"))
 set termguicolors
endif
colorscheme OceanicNext
set guifont=FiraMono:h11
set listchars=tab:\ \ ,trail:~,extends:>,precedes:<,lead:·
set list
highlight Folded ctermbg=Black
highlight Conceal ctermbg=Black
highlight Comment cterm=italic gui=italic

autocmd Filetype tex  setlocal makeprg=latexmk
autocmd Filetype tex  setlocal shiftwidth=2
autocmd Filetype tex  setlocal tabstop=2
autocmd Filetype tex  setlocal noexpandtab
autocmd Filetype tex  setlocal textwidth=100
autocmd Filetype tex  setlocal foldmethod=expr
autocmd Filetype tex  setlocal foldexpr=nvim_treesitter#foldexpr()
autocmd Filetype tex  setlocal foldlevel=2
