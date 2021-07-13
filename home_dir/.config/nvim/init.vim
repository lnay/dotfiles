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
EOF
syntax enable

set number
set relativenumber
set mouse=a
set tabstop=4
set shiftwidth=4

colorscheme slate
let g:airline_powerline_fonts = 1
set listchars=trail:~,extends:>,precedes:<,lead:·
set list
highlight Folded ctermbg=Black
highlight Conceal ctermbg=Black
highlight SignColumn ctermbg=None
highlight GitGutterAdd ctermbg=None ctermfg=Green
highlight GitGutterChange ctermbg=None ctermfg=Yellow
highlight GitGutterDelete ctermbg=None ctermfg=Red


autocmd Filetype tex  setlocal makeprg=latexmk
autocmd Filetype tex  setlocal shiftwidth=2
autocmd Filetype tex  setlocal tabstop=2
autocmd Filetype tex  setlocal expandtab
autocmd Filetype tex  setlocal conceallevel=2
autocmd Filetype tex  setlocal foldmethod=expr
autocmd Filetype tex  setlocal foldexpr=nvim_treesitter#foldexpr()
autocmd Filetype tex  setlocal foldlevel=2
