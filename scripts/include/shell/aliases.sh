alias find="fd"
alias grep="rg"
alias keycodes="xmodmap -pke"
alias c='cd "$(fd --type d --hidden --follow --exclude .git | fzf)"'
alias p='cd "$(ls ~/code/*/project/* -d | fzf)"'
alias e="fd --type f --hidden --follow --exclude .git | fzf | xargs -r nvim"
alias cdc="cd ~/code"
alias cdd="cd ~/download"
alias cdi="cd ~/image"
alias cdr="cd ~/.myrice"
alias cdm="cd ~/music"

