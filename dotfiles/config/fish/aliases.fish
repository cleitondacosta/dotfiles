alias keycodes 'xmodmap -pke'
alias c 'cd "$(fd --type d --hidden --follow --exclude .git | fzf)"'
alias er 'cd ~/.myrice && nvim .'
alias e 'fd --type f --hidden --follow --exclude .git | fzf --preview \'bat --style=plain --color=always {}\' | xargs -r nvim'
alias t '$TERM & disown'
alias cdc 'cd ~/code'
alias cdd 'cd ~/download'
alias cdi 'cd ~/image'
alias cdbg 'cd ~/image/bg'
alias cdv 'cd ~/video'
alias cdh 'cd ~'
alias cdr 'cd ~/.myrice'
alias cdn 'cd ~/.config/nvim'
alias cdm 'cd ~/music'
alias cdg 'cd "$(git rev-parse --show-toplevel)"'
alias cdwp 'cd ~/work/projects'
alias cdp 'cd ~/projects'
alias update_pacman_mirrorlist 'sudo reflector --sort rate --save /etc/pacman.d/mirrorlist -c br && sudo pacman -Sy'
alias list_installed_fonts 'fc-list'
alias get_sound_volume 'pactl get-sink-volume @DEFAULT_SINK@ | grep Volume | awk \'{print $5}\' | tr \'%\' \' \''
alias increase_sound_volume 'pactl set-sink-volume @DEFAULT_SINK@ +5%'
alias decrease_sound_volume 'pactl set-sink-volume @DEFAULT_SINK@ -5%'
alias set_background_image 'feh --bg-fill ~/.bg'
alias n "nvim"
alias bot "btm --process_memory_as_value"
alias tl 'task list'
alias ta 'task add'

function cd_fuzzy_projects -a projects_basedir
    set directory "$(fd -H --type d '^.git$' "$projects_basedir" -X dirname | fzf -1 -q "$argv")"

    if not test -d "$directory"
        return 1
    end

    cd "$directory"

    if test -f '.nvmrc' && type -q nvm
        nvm use
    end

    return 0
end

alias p 'cd_fuzzy_projects ~/projects'
alias ep 'cd_fuzzy_projects ~/projects && nvim .'
alias wp 'cd_fuzzy_projects ~/work/projects'
alias ewp 'cd_fuzzy_projects ~/work/projects && nvim .'

