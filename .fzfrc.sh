# https://github.com/junegunn/fzf/wiki/Color-schemes#one-dark
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'

# require: bat
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--preview="bat -p --color=always --tabs 3 --theme OneHalfDark {} | head -100"
--preview-window=right:70%:wrap
--reverse
'

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--cycle
--bind "ctrl-v:toggle-preview,ctrl-j:preview-down,ctrl-k:preview-up,alt-j:preview-page-down,alt-k:preview-page-up,ctrl-e:execute(echo '' | xargs -o vim '{}' >/dev/tty)"
'
