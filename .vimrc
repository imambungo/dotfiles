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
autocmd Filetype json setlocal tabstop=2 expandtab
autocmd Filetype javascript,dart,html call SetTabSettings()

" https://stackoverflow.com/a/1413352/9157799
function SetTabSettings()
	setlocal tabstop=3
	call SetTabShifting()
endfunction

" like tmux, this should be the default
set splitright
set splitbelow

set nu rnu
set is hls ic
set wildignore=*.class
set scrolloff=5
set colorcolumn=80
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

"Clear highlight on pressing 'ESC'
nnoremap <c-l> :noh<return>

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
set statusline+=%F\ %y

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

" fix: Alt key mappings doesn't work
" https://vi.stackexchange.com/a/10506/20429
for i in range(97,122)
  let c = nr2char(i)
  exe "set <m-".c.">=\e".c
endfor

" mappings to resize vim window
" in an ideal world: noremap <c-right> <c-w>>
" How to reproduce:
" $ cat              # in shell, type cat and shift-enter
" [1;5C            # press ctrl-right, you'll see ^[[1;5C
"                      where  is the escape key
noremap <esc>[1;5C <c-w>>
noremap <esc>[1;5D <c-w><
noremap <esc>[1;5A <c-w>+
noremap <esc>[1;5B <c-w>-

" ctrl-w t  -->  "split" to new tab
nnoremap <c-w>t <c-w>s<c-w>T

" command mode
cnoremap <c-u> <c-e><c-u>
cnoremap <m-f> <s-right>
cnoremap <m-b> <s-left>

" insert + command mode
noremap! <c-d> <del>
noremap! <c-a> <home>
noremap! <c-f> <right>
noremap! <c-b> <left>

" insert mode
imap <m-f> <c-o>w
imap <m-b> <c-o>b
inoremap <c-e> <end>

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

inoremap (<esc> (<esc>

" strange behavior: malah nge-enable paste pake ctrl-v
"                   ctrl-shift-v dk ad perubahan
" diagnosa: shift doesn't work
" ternyata: https://vi.stackexchange.com/a/4291/20429
" to prevent auto closing parens when pasting
inoremap <c-s-v> <c-o>p

autocmd Filetype dart inoremap [<cr> [<cr>],<c-o>O<tab>
au Filetype dart inoremap (<cr> (<cr>),<c-o>O<bs><bs>
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
function SetTabShifting()
	nnoremap >> 0i<tab><esc>^
	nnoremap << :norm 0ldF<tab><enter>^
	vnoremap > :norm 0i<tab><enter>gv
	vnoremap < :norm 0ldF<tab><enter>gv
endfunction

" Temporary `gx` fix
" note: - unlike google-chrome, xdg-open need https:// to be in the URL
"       - if the default browser is chrome, xdg-open will print "Opening in
"         existing browser session"
" https://github.com/vim/vim/issues/4738#issuecomment-798790444
function! OpenURLUnderCursor()
	let s:uri = expand('<cWORD>')
	let s:uri = matchstr(s:uri, "[a-z]*:\/\/[^ >,;)'\"]*")
	let s:uri = substitute(s:uri, '#', '\\#', '')
	if s:uri != ''
		silent exec "!xdg-open '".s:uri."' > /dev/null"
		:redraw!
	endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>
" sil[ent] --> obliterate "Press ENTER or type command to continue" from shell
"
" redr[aw]! --> redraw vim screen after m̶e̶s̶s̶e̶d̶ ̶u̶p̶ silenced by sil[ent]
"
" > /dev/null (default to 1> /dev/null) --> because we use sil[ent], the
" "Opening in existing browser session" get escaped to vim screen, and
" redr[aw]! can't prevent it

" move the cursor through long soft-wrapped lines
" https://stackoverflow.com/a/21000307/9157799
noremap <expr> j v:count ? 'j' : 'gj'
noremap <expr> k v:count ? 'k' : 'gk'

inoremap <C-l> <esc>
vnoremap <C-l> <esc>

" when there are multiple definitions, select 1 in a quick dialog
" see  -->  :h g
nnoremap <c-]> g<c-]>

" switch buffer to terminal
" :ter[minal]  -->  open terminal in NEW window
nnoremap <c-s> :ter ++curwin<cr>

" https://stackoverflow.com/a/61996363/9157799
tnoremap <c-[> <c-\><c-n>

" https://stackoverflow.com/a/6528201/9157799
" w     : forward to next word beginning with alphanumeric char
" b     : backward to prev word beginning with alphanumeric char
" <c-h> : back to prev word ending with alphanumeric char
function! <SID>GotoPattern(pattern, dir) range
    let g:_saved_search_reg = @/
    let l:flags = "We"
    if a:dir == "b"
        let l:flags .= "b"
    endif
    for i in range(v:count1)
        call search(a:pattern, l:flags)
    endfor
    let @/ = g:_saved_search_reg
endfunction
nnoremap <silent> w :<C-U>call <SID>GotoPattern('\(^\\|\<\)[A-Za-z0-9_]', 'f')<CR>
vnoremap <silent> w :<C-U>let g:_saved_search_reg=@/<CR>gv/\(^\\|\<\)[A-Za-z0-9_]<CR>:<C-U>let @/=g:_saved_search_reg<CR>gv
nnoremap <silent> b :<C-U>call <SID>GotoPattern('\(^\\|\<\)[A-Za-z0-9_]', 'b')<CR>
vnoremap <silent> b :<C-U>let g:_saved_search_reg=@/<CR>gv?\(^\\|\<\)[A-Za-z0-9_]<CR>:<C-U>let @/=g:_saved_search_reg<CR>gv
nnoremap <silent> <c-h> :call <SID>GotoPattern('[A-Za-z0-9_]\(\>\\|$\)', 'b')<CR>
vnoremap <silent> <c-h> :<C-U>let g:_saved_search_reg=@/<CR>gv?[A-Za-z0-9_]\(\>\\|$\)<CR>:<C-U>let @/=g:_saved_search_reg<CR>gv

nnoremap ; :
nnoremap : ;

" syntax highlighting for svelte files
au! BufNewFile,BufRead *.svelte set ft=html

set tags+=./tags;  " don't forget to install universal-ctags
" https://stackoverflow.com/a/741486/9157799

" https://vi.stackexchange.com/a/19463/20429
" https://stackoverflow.com/a/12154601/9157799
au FileType python set tags+=~/.local/lib/python3.6/site-packages/tags
au FileType python set tags+=~/.local/lib/python2.7/site-packages/tags
" to toggle: https://stackoverflow.com/a/43125342/9157799

" set working directory to the repo root of current buffer when available
" https://stackoverflow.com/a/38082157/9157799
au BufRead * exe 'cd %:h | sil cd `git rev-parse --show-toplevel`'

" TODO: give correct result when there are uncommitted changes
" TODO: show all changes of the commits instead of just the highlighted one
" TODO: ctrl-b without highlighting
" https://stackoverflow.com/a/19757493/9157799
" https://stackoverflow.com/a/2517412/9157799
" https://vim.fandom.com/wiki/Get_the_name_of_the_current_file
" :h exe
command! MyGitBlame exe '!git log -L' line("'<").','.line("'>").':'.expand('%')
noremap <c-b> :<c-u>MyGitBlame<cr>

" allow switching from terminal or modified file buffer
set hidden
