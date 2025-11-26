alias c 'cd "$(fd --type d --hidden --follow --exclude .git | fzf)"'
alias er 'cd ~/.myrice && nvim .'
alias e 'fd --type f --hidden --follow --exclude .git | fzf --preview \'bat --style=plain --color=always {}\' | xargs -r nvim'
alias t '$TERM & disown'
alias cdr 'cd ~/.myrice'
alias cdg 'cd "$(git rev-parse --show-toplevel)"'
alias cdwp 'cd ~/work/projects'
alias cdp 'cd ~/projects'
alias list_installed_fonts 'fc-list'
alias bot "btm --process_memory_as_value"

function cd_fuzzy_projects
    set projects_basedir "$argv[1]"
    set directory "$(fd -H --type d '^.git$' "$projects_basedir" -X dirname | fzf -1 -q "$argv[2..-1]")"

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
alias wp 'cd_fuzzy_projects ~/work/projects'
function ep; cd_fuzzy_projects ~/projects $argv && nvim .; end
function ewp; cd_fuzzy_projects ~/work/projects $argv && nvim .; end
