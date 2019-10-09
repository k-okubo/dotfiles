" -----------------------------------------------------------------------------
" vim-plug
" -----------------------------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bronson/vim-trailing-whitespace'
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/local_vimrc'
Plug 'tomasr/molokai'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
Plug 'ludwig/split-manpage.vim'
Plug 'rhysd/vim-clang-format'

Plug 'vim-perl/vim-perl'
Plug 'c9s/perlomni.vim'

call plug#end()

filetype on
filetype plugin on
filetype indent on

" -----------------------------------------------------------------------------
" basic
" -----------------------------------------------------------------------------
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932
set fileformats=unix,dos,mac

set modeline
set modelines=5

set ttyfast
set backspace=indent,eol,start
let mapleader=','
set hidden

set hlsearch
set incsearch
set ignorecase
set smartcase

nnoremap <silent> <leader>sh :terminal<CR>
nnoremap <silent> <leader><space> :noh<CR>
noremap <leader>w :bp<CR>
noremap <leader>e :bn<CR>
noremap <leader>q :bn<CR>:bd #<CR>
tnoremap <Esc> <C-\><C-n>

" visual
syntax on
set ruler
set number
set scrolloff=5

set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

set title
set titleold="Terminal"
set titlestring=%F
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)

if &t_Co == "256"
  colorscheme molokai
  highlight Directory ctermfg=112
  highlight Function ctermfg=112
  highlight PreProc ctermfg=112
  highlight PreCondit ctermfg=112
  highlight Label ctermfg=184
  " highlight Visual ctermbg=236
  " highlight Comment ctermfg=102
endif

" -----------------------------------------------------------------------------
"  File type settings
" -----------------------------------------------------------------------------

" c
autocmd FileType c setlocal tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 noexpandtab

" perl
autocmd FileType perl setlocal tabstop=2 shiftwidth=2 expandtab

" ruby
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 expandtab

" html
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" -----------------------------------------------------------------------------
"  Plugin settings
" -----------------------------------------------------------------------------

" nerdtree
let g:NERDTreeChDirMode=2
let g:NERDTreeShowBookmarks=1
let g:NERDTreeCaseSensitiveSort=1
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>

" ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_highlights = 0
let g:ale_linters = {
      \ 'c': ['cquery'],
      \ 'cpp': ['cquery'],
      \}

" clang-format
let g:clang_format#detect_style_file = 1

" airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

" Load settings for each location
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
