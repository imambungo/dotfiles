set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'wakatime/vim-wakatime'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set tabstop=4
set shiftwidth=0

" source: https://stackoverflow.com/a/2054782/9157799
" check the filetype with  :set ft?
autocmd Filetype dart,html setlocal tabstop=2
autocmd Filetype javascript setlocal tabstop=3

set nu rnu
set is hls ic
set wildignore=*.class
set scrolloff=5
set colorcolumn=80
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

"Clear highlight on pressing double ESC
nnoremap <esc><esc> :noh<return>

"vnoremap <C-C> :w !xclip -i -sel c<CR><CR>
"vnoremap y :w !xclip -i -sel c<CR><CR>
"vnoremap p :r !xclip -o -sel -c<CR><CR> "not working?
set clipboard=unnamedplus "this need `sudo apt-get install vim-gui-common

" this will prevent vim from clearing the clipboard on exit
autocmd VimLeave * call system("xsel -ib", getreg('+')) "need xsel installed!
"autocmd VimLeave * call system("xclip -o | xclip -selection c")

"ONEDARK
"packadd! onedark.vim
""
"""Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
""If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
""(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
"if (empty($TMUX))
"  if (has("nvim"))
"    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"  endif
"  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
"  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"  if (has("termguicolors"))
"    set termguicolors
"  endif
"endif
""
"syntax on
"colorscheme onedark
"ONEDARK

"GRUVBOX
"colorscheme gruvbox
"set background=dark    " Setting dark mode
"GRUVBOX

"PALENIGHT
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'drewtempelmeyer/palenight.vim'
Plugin 'w0rp/ale'
Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
"Plug 'tpope/vim-sensible'
"Plug 'junegunn/seoul256.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set background=dark
colorscheme palenight
let g:palenight_terminal_italics=1
"PALENIGHT

autocmd! FileType c,cpp,java,php call CSyntaxAfter()
hi Normal ctermbg=NONE guibg=NONE
highlight LineNr ctermfg=grey
highlight Comment    ctermfg=DarkGrey
hi ColorColumn ctermbg=239
"highlight Identifier ctermfg=99AA00

set foldmethod=indent
" au BufRead source: https://stackoverflow.com/a/8316817/9157799
au BufRead * normal zR
" below: save fold state
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
" below: don't save the options
" https://vi.stackexchange.com/q/24602/20429
set viewoptions-=options

" MRU (Most Recently Used)
" source: https://stackoverflow.com/a/22701319/9157799
" this is our 'main' function: it couldn't be simpler
function! Mru(arg)
    execute 'edit ' . a:arg
endfunction

" the completion function, again it's very simple
function! MRUComplete(ArgLead, CmdLine, CursorPos)
    return filter(copy(v:oldfiles), 'v:val =~ a:ArgLead')
endfunction

" the actual command
" it accepts only one argument
" it's set to use the function above for completion
command! -nargs=1 -complete=customlist,MRUComplete Mru call Mru(<f-args>)

" https://vi.stackexchange.com/a/105/20429
set laststatus=2
set statusline+=%F

" https://stackoverflow.com/a/1272247/9157799
set fo+=t

let g:lsc_auto_map = v:true

" ALE config
let g:ale_linters = {
\   'dart': ['language_server'],
\}
let g:ale_fixers = {
\   'dart': ['dartfmt'],
\}

let g:lsc_server_commands = {'dart': 'dart_language_server'}

" https://stackoverflow.com/a/6071166/9157799
inoremap {<cr> {<cr>}<c-o>O
inoremap [<cr> [<cr>]<c-o>O
inoremap (<cr> (<cr>)<c-o>O

" auto closing bracket
inoremap { {}<left>
inoremap [ []<left>
inoremap ( ()<left>

" no auto closing bracket if empty
inoremap () ()
inoremap [] []
inoremap {} {}

" ctrl-L for right arrow key in insert mode
" useful to get past through closing parens
inoremap <c-l> <right>

" to prevent auto closing parens when pasting
inoremap <c-v> i<c-o>vp

autocmd Filetype dart inoremap [<cr> [<cr>],<c-o>O<tab>
autocmd Filetype dart inoremap (<cr> (<cr>),<c-o>O<bs><bs>
autocmd Filetype dart nnoremap <c-i> lbi(<cr><bs><bs><bs><bs>child: <esc>f(%o),<esc>k$F)v%>k$i

" https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

set rtp+=/home/imampt/.linuxbrew/opt/fzf

" don't touch the spaces when shifting
" https://vi.stackexchange.com/a/24624/20429
nnoremap >> 0i<tab><esc>^
nnoremap << :norm 0ldF<tab><enter>^
vnoremap > :norm 0i<tab><enter>gv
vnoremap < :norm 0ldF<tab><enter>gv

" temporary `gx` fix
" https://github.com/vim/vim/issues/4738#issuecomment-521506447
nmap gx yiW:!xdg-open <cWORD><CR> <C-r>" & <CR><CR>

" move the cursor through long soft-wrapped lines
" https://stackoverflow.com/a/21000307/9157799
noremap <expr> j v:count ? 'j' : 'gj'
noremap <expr> k v:count ? 'k' : 'gk'
