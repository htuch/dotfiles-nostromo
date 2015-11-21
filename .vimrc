filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

" Lusty Juggler/Explorer file and buffer explorer
Plugin 'https://github.com/sjbach/lusty.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Enable syntax highlighting by default.
syntax on

" Colorscheme setup.
set t_Co=256
let g:zenburn_force_dark_Background = 1
let g:zenburn_high_Contrast = 1
let g:zenburn_old_Visual = 1
let g:zenburn_alternate_Visual = 1
colors zenburn

" Powerline setup.
set noshowmode
set laststatus=2
set rtp+=~/.powerline/powerline/bindings/vim

" Avoid dashed lines on vsplits
set fillchars+=vert:\ 

" Jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" Basic settings
"
set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hlsearch        " Highlight search matches
set hidden          " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals
set autoread        " Re-read file when switching back to window
set visualbell      " No noise
"set lazyredraw      " Don't redraw in macros etc. (break Powerline at startup)
set ttyfast         " Some optimizations for modern terminals

" Base wrap width. Doesn't automatically wrap but will apply during reformatting
" and when wrapping is enabled.
set textwidth=80

" Wrap visually by default (i.e. don't modify buffer).
set wrap

" Default to relative line numbers (toggle with ,n).
set relativenumber

" Tab completion in command mode.
set wildmode=longest,list

" ctrl-n/p token completion. By default this uses buffer contents.
set completeopt=longest,menu

" Detect when files are modified by other agents.
"
" Non-gvim approach to file modification detection from
" http://stackoverflow.com/a/10962191
augroup CheckTime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter        * silent! checktime
        autocmd CursorHold      * silent! checktime
        autocmd CursorHoldI     * silent! checktime
        "these two _may_ slow things down. Remove if they do.
        autocmd CursorMoved     * silent! checktime
        autocmd CursorMovedI    * silent! checktime
    endif
augroup END

" Mitigate some escape delay issues encountered.
set ttimeoutlen=10
augroup FastEscape
    au!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
augroup END

" Configure spell but don't enable by default.
set spelllang=en_us
set spellfile=.spell.add,~/.spell.add
"set spell

" Highlight whitespace at EOL with red.
hi WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" Disable some distracting colors.
hi SignColumn ctermbg=None
hi Folded ctermbg=None

" Highlight options when displaying the cursor line with ,c.
hi CursorLine ctermbg=LightYellow ctermfg=Black

" Sane default tabs. These are overriden by the FileTypeConfig group.
"
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces

" cscope support
"
" s: Find this C symbol
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
" g: Find this definition
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
" d: Find functions called by this function
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
" c: Find functions calling this function
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
" t: Find this text string
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
" e: Find this egrep pattern
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
" f: Find this file
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
" i: Find files #including this file
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" Search parent directories for cscope files
execute 'cs add ' fnamemodify(findfile('cscope.out', '.;/'), ':p')

" Localized settings when editing different types of files.
augroup FileTypeConfig
    au!
    au FileType rust,c,h,cpp,sh setlocal shiftwidth=4 softtabstop=4 expandtab cino=l1,(0,W0,t0 tw=80
    au FileType java,m setlocal shiftwidth=4 softtabstop=4 expandtab cino=l1 tw=80
    au FileType smv setlocal shiftwidth=2 softtabstop=2 expandtab cino=l1 tw=220
    au FileType xml setlocal shiftwidth=2 softtabstop=2 expandtab cino=l1 tw=220
    au FileType asm setlocal shiftwidth=4 softtabstop=4 expandtab cino=l1
    au FileType html,css,coffee,javascript,hs setlocal shiftwidth=2 softtabstop=2 expandtab cino=l1
    au FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab cino=l1
    au FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab
    au FileType python,sc setlocal shiftwidth=4 softtabstop=4 expandtab cino=l1
    au FileType gitcommit set tw=72
    au BufNewFile,BufRead *.sc set filetype=python
augroup END

" Enable filetype plugin indentation settings from above and ~/.vim/indent
filetype indent on

" .vimrc edit/reload
nnoremap ,v :split ~/.vimrc<Enter>
nnoremap ,V :source ~/.vimrc<Enter>

" Lusty Juggler/Explorer plugin
map ,f <Leader>lf
map ,h <Leader>lr
map ,b <Leader>lb
map ,j <Leader>lj
noremap ,p :LustyJugglePrevious<Enter>
let g:LustyJugglerShowKeys = 'a'

" Disable search highlighting from previous search
noremap ,s :noh<Enter>

" Paste in previous line remainder and enter insert mode.
nnoremap ,l kywjpi

" xmllint file
nnoremap ,x :%!xmllint --format -<Enter>

" HTML/markdown conversion
nnoremap ,M :%!pandoc --from=html --to=markdown -<Enter>
nnoremap ,H :%!pandoc --from=markdown --to=html -<Enter>
nnoremap ,T :%!pandoc --from=html --to=plain -<Enter>
nnoremap ,P :%d<Enter>i<pre><Esc>pGo</pre><Esc>

" Toggles
noremap ,c :setlocal cursorline!<CR> " Toggle cursor line highlighting
noremap ,t :setlocal paste!<CR>
noremap ,n :setlocal number!<CR>:setlocal relativenumber!<CR>

" Simple abbreviations.
ab #i #include
ab #d #define
