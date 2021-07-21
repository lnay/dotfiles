"dein Scripts-----------------------------

" Required:
set runtimepath+=/home/luke/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/home/luke/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('/home/luke/.cache/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
call dein#add('lervag/vimtex')
call dein#add('morhetz/gruvbox')
call dein#add('tomasiser/vim-code-dark')
call dein#add('tomasr/molokai')
call dein#add('embark-theme/vim')
call dein#add('mhartington/oceanic-next')
call dein#add('airblade/vim-gitgutter')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-fugitive')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('nvim-treesitter/nvim-treesitter')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}

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

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {"texlab"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

set number
set relativenumber
set mouse=a
set tabstop=4
set shiftwidth=4

if (has("termguicolors"))
 set termguicolors
endif
colorscheme OceanicNext
set guifont=FiraMono
let g:airline_powerline_fonts = 1
set listchars=trail:~,extends:>,precedes:<,lead:·
set list
highlight Folded ctermbg=Black
highlight Conceal ctermbg=Black
highlight SignColumn ctermbg=None
highlight GitGutterAdd ctermbg=None ctermfg=Green
highlight GitGutterChange ctermbg=None ctermfg=Yellow
highlight GitGutterDelete ctermbg=None ctermfg=Red
highlight Comment cterm=italic gui=italic

autocmd Filetype tex  setlocal makeprg=latexmk
autocmd Filetype tex  setlocal shiftwidth=2
autocmd Filetype tex  setlocal tabstop=2
autocmd Filetype tex  setlocal expandtab
autocmd Filetype tex  setlocal conceallevel=2
autocmd Filetype tex  setlocal foldmethod=expr
autocmd Filetype tex  setlocal foldexpr=nvim_treesitter#foldexpr()
autocmd Filetype tex  setlocal foldlevel=2
