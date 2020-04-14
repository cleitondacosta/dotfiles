" See :help map-which-keys
" leader
    let mapleader=","

" Status bar
    set showcmd
    set laststatus=2

" Indent
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
    set autoindent
    set smartindent
    filetype on
    autocmd FileType ruby,tex,html,javascript,css,scss,json,typescript,tsx,typescriptreact
        \ setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Search
    set nohlsearch
    set ignorecase
    set smartcase

" Line number
    set nu
    set relativenumber

" Max chars per line
    set colorcolumn=80
    set textwidth=80

" Misc
    set ttimeoutlen=100

" Throws the content after the cursor to the line below
    nnoremap <CR> i<Enter><esc>k$

" Commands
    command Nvimrc tabe ~/.config/nvim/init.vim
    command Mainsplit vertical resize 84

" Plugins (Requires vim-plug)
    call plug#begin('~/.config/nvim/bundle')
        Plug 'scrooloose/nerdcommenter'
        Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'javascript', 'typescriptreact']}
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'Raimondi/delimitMate'
        Plug 'michaeljsmith/vim-indent-object'
        Plug 'tpope/vim-surround'
        Plug 'wellle/targets.vim'
        Plug 'donRaphaco/neotex', { 'for': 'tex' }
        Plug 'sheerun/vim-polyglot'
        Plug 'morhetz/gruvbox'
        Plug 'junegunn/fzf.vim'
    call plug#end()

" fzf
"
" This function uses a git command to get the root
" directory of a git project and pass it to fzf if it was
" found
function! RunFZFOnProjectRootDir()
    let rootdir = system('git rev-parse --show-toplevel')

    if v:shell_error == 0
        let rootdir_without_newline = rootdir[:-2]
        call fzf#vim#files(rootdir_without_newline)
    else
        Files
    endif
endfunction

nmap <leader>o :call RunFZFOnProjectRootDir()<CR>
nmap <leader>t :tabe<CR>:call RunFZFOnProjectRootDir()<CR>
nmap <leader>vs :vsplit<CR>:call RunFZFOnProjectRootDir()<CR>

" Latex config
augroup latexconf
    autocmd!
    autocmd FileType tex let g:tex_flavor = 'latex'
    autocmd FileType tex nnoremap <leader>le :NeoTexOn<CR>
    autocmd FileType tex nnoremap <leader>ld :NeoTexOff<CR>
    autocmd FileType tex nnoremap <F9>
        \ <esc>:!FILENAME=%; zathura ${FILENAME\%.*}.pdf &<CR><CR>
augroup end

" Emmet
    autocmd FileType html,css,javascript.jsx EmmetInstall
    let g:user_emmet_leader_key = ','
    let g:user_emmet_settings = {
        \  'javascript' : {
        \      'extends': 'jsx',
        \      'quote_char': "'",
        \  },
        \}

" Color
    colorscheme gruvbox
    set cursorline
    highlight ColorColumn ctermbg=darkgray
