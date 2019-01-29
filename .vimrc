set tabstop=4
set shiftwidth=4
set nu "rnu
set is hls ic
set wildignore=*.class
set scrolloff=5
set colorcolumn=80

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
