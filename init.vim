filetype plugin indent on
syntax on

set guicursor=i:block
set cursorline
set ruler
set number
set hidden
set shortmess+=c

set incsearch
set showmatch
set ignorecase

set tabstop=2 softtabstop=2
set shiftwidth=2
set smarttab
set autoindent
set nowrap
" set cc=80

set mouse=v
set mouse=a
set clipboard=unnamedplus

set background=dark
set termguicolors

set laststatus=0
set cmdheight=2
set updatetime=150
set timeoutlen=250

set nobackup
set nowritebackup
set noswapfile

call plug#begin("~/.config/nvim/plugged")
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'dracula/vim', {'as':'dracula'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf',{'do':{-> fzf#install()} }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
call plug#end()
colorscheme dracula
source $HOME/dotfiles/coc.vim

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nnoremap <C-s> :wa<CR>
nnoremap <C-c> <Esc>
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>
nnoremap <C-p> :GFiles<CR>
" inoremap jk <Esc>
" inoremap kj <Esc>
" inoremap <expr> <c-j> ("\<C-n>")
" inoremap <expr> <c-k> ("\<C-p>")
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

let g:python3_host_prog = '/usr/bin/python3.8'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dracula' 
let g:airline_powerline_fonts = 1
