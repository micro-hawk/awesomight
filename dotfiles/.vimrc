"ooo        ooooo  o8o                               ooooo   ooooo                            oooo        
"`88.       .888'  `"'                               `888'   `888'                            `888        
" 888b     d'888  oooo   .ooooo.  oooo d8b  .ooooo.   888     888   .oooo.   oooo oooo    ooo  888  oooo  
" 8 Y88. .P  888  `888  d88' `"Y8 `888""8P d88' `88b  888ooooo888  `P  )88b   `88. `88.  .8'   888 .8P'   
" 8  `888'   888   888  888        888     888   888  888     888   .oP"888    `88..]88..8'    888888.    
" 8    Y     888   888  888   .o8  888     888   888  888     888  d8(  888     `888'`888'     888 `88b.  
"o8o        o888o o888o `Y8bod8P' d888b    `Y8bod8P' o888o   o888o `Y888""8o     `8'  `8'     o888o o888o 
                                                                                                         


call plug#begin('~/.vim/plugged')
"packadd! dracula


Plug 'https://github.com/rafi/awesome-vim-colorschemes.git'
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'wfxr/minimap.vim'
Plug 'ghifarit53/tokyonight-vim'

" theme Github
Plug 'wojciechkepka/vim-github-dark'

" Oceanic Theme
Plug 'mhartington/oceanic-next'
call plug#end()


set nocompatible              " be iMproved, required
filetype off                  " required

syntax enable               "enable syntax processing
set noerrorbells
set tabstop=4                   " number of visual spaces per TAB
set softtabstop=4               " number of spaces in tab when editing
set shiftwidth=4
set expandtab                   " tabs are spaces
set smartindent
set number                      "Show numbers
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set showcmd             "Show command in bottom
set cursorline          "highlight the current line


filetype indent on   " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.

set showmatch           " highlight matching [{()}]

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" autocomplete the matching braces:: :VIM :)
inoremap { {<CR>}<Esc>ko


set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max


" space open/closes folds
nnoremap <space> za

set foldmethod=indent   " fold based on indent level





" move vertically by visual line
nnoremap j gj
nnoremap k gk
" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]



let mapleader=","       " leader is comma

" jk is escape
inoremap jk <esc>

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" save session
nnoremap <leader>s :mksession<CR>

" open ag.vim
nnoremap <leader>a :Ag

" for vim 7
 set t_Co=256

" for vim 8
 if (has("termguicolors"))
  set termguicolors
 endif




""""""""""""""""""""""""""""""""""""""""""""""
"           COLORSCHEMES of ALL COLORS      "
    " just uncomment whatever you want :))
""""""""""""""""""""""""""""""""""""""""""""""


" colorscheme ghdark 
"
"colorscheme OceanicNext
"colorscheme 256_noir
"colorscheme abstract
"colorscheme afterglow
"colorscheme atom
"colorscheme deep-space
"colorscheme dracula
"colorscheme flattened_dark
"colorscheme flattened_light
"colorscheme github
" colorscheme gruvbox
"colorscheme happy_hacking
"colorscheme hybrid
"colorscheme onedark
"colorscheme lucid
"colorscheme materialbox
"colorscheme meta5
"colorscheme minimalist
"colorscheme molokai
"colorscheme nord
"colorscheme one
"colorscheme wombat256
"colorscheme twilight256

set termguicolors

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

colorscheme tokyonight

set background=dark


" for transparent background
function! AdaptColorscheme()
   highlight clear CursorLine
   highlight Normal ctermbg=none
   highlight LineNr ctermbg=none
   highlight Folded ctermbg=none
   highlight NonText ctermbg=none
   highlight SpecialKey ctermbg=none
   highlight VertSplit ctermbg=none
   highlight SignColumn ctermbg=none
endfunction
autocmd ColorScheme * call AdaptColorscheme()

highlight Normal guibg=NONE ctermbg=NONE
highlight CursorColumn cterm=NONE ctermbg=NONE ctermfg=NONE
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE
highlight CursorLineNr cterm=NONE ctermbg=NONE ctermfg=NONE
highlight clear LineNr
highlight clear SignColumn
highlight clear StatusLine


" Change Color when entering Insert Mode
autocmd InsertEnter * set nocursorline

" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * set nocursorline

"" extra settings, uncomment them if necessary :)
"set cursorline
"set noshowmode
"set nocursorline

" trasparent end
"
let g:minimap_width = 7
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1
let g:minimap_highlight_search = 1
let g:minimap_highlight_range = 1
