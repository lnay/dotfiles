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
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-fugitive')
call dein#add('hrsh7th/nvim-cmp')
call dein#add('hrsh7th/cmp-nvim-lsp')
call dein#add('saadparwaiz1/cmp_luasnip')
call dein#add('L3MON4D3/LuaSnip')
call dein#add('rafamadriz/friendly-snippets')

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
let g:airline_powerline_fonts = 1 " needed for vim airline
lua <<EOF
require('gitsigns').setup()
EOF

"End dein Scripts-------------------------

" TREESITTER CONFIGS
" ========== =======

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
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

  buf_set_keymap("i", "<C-n>", "<cmd>lua vim.lsp.omnifunc()<CR>", opts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {"texlab","denols","cssls","dockerls"}
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
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
EOF

set number
set relativenumber
set mouse=a
set tabstop=4
set shiftwidth=4
set noexpandtab

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
autocmd Filetype tex  setlocal expandtab
autocmd Filetype tex  setlocal textwidth=100
autocmd Filetype tex  setlocal foldmethod=expr
autocmd Filetype tex  setlocal foldexpr=nvim_treesitter#foldexpr()
autocmd Filetype tex  setlocal foldlevel=2
