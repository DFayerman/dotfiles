set guicursor=i:block
set cursorline
set ruler
set showmatch
set ignorecase
set autoindent
set number
filetype plugin indent on
syntax on
set cc=80
set mouse=v
set mouse=a
set incsearch
set clipboard=unnamedplus
set background=dark
set termguicolors
set cmdheight=2
set updatetime=300
set timeoutlen=500
set nobackup
set nowritebackup
set tabstop=2 softtabstop=2
set shiftwidth=2
set smarttab
set noswapfile
set nowrap
set laststatus=0

call plug#begin("~/nvim/plugged")
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
source $HOME/.config/nvim/coc.vim

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nnoremap <C-c> <Esc>
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>
nnoremap <C-p> :FZF<CR>
inoremap jk <Esc>
inoremap kj <Esc>
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dracula' 
let g:airline_powerline_fonts = 1
