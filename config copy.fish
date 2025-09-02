eval (/opt/homebrew/bin/brew shellenv)

# Modern replacements for cli tools
alias vim=nvim
alias v=nvim
alias ls="eza --icons"
alias cat=bat
alias htop=zenith
alias pip="uv pip"
alias ranger=yazi
alias y=yazi
alias find=fd
alias grep="rg -i"
alias du=dust
alias tmux=zellij
zoxide init fish | source
alias cd=z
alias ff=fzf
alias devdash="zellij -l ~/.config/zellij/layouts/dev-dashboard.kdl"
alias lg=lazygit
alias ld=lazydocker

export EDITOR=nvim

alias c="open $1 -a \"Cursor\""
alias npx=bunx
alias pnpx=bunx
alias mj="make -j"
alias python=python3
alias dx="docker compose exec"
alias dx-dev="docker compose -f docker-compose.dev.yaml exec dev pnpm"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export PNPM_HOME="/Users/haukeschnau/Library/pnpm"
export SSH_AUTH_SOCK=/Users/haukeschnau/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock
export ANDROID_HOME=/Users/haukeschnau/Library/Android/sdk
fish_add_path $PNPM_HOME
fish_add_path "/opt/homebrew/opt/postgresql@16/bin"
fish_add_path "/Users/haukeschnau/.bun/bin"
fish_add_path "/Users/haukeschnau/go/bin"
fish_add_path "/Users/haukeschnau/.spin/bin"

set -x npm_token OGE2YjQ4OWE0Y2M3ZjNlM2U5ZjJlNDk2NjYyNjZmMjU6ODdlNjk2MWI4Y2MzOTkxY2VjOTQ2MTgxM2I1ZjY3 
set -x AVANTE_GEMINI_API_KEY AIzaSyDQJl0IaxxJLh674xyCEE5kXqFw1GUKAFI
set -x BW_SESSION hKC8HpululLfck7vLF1pTdk0ZlRKbrfeHdiwEpTaEcokaw9NogDC+Vcg9vbixC7XEw2i/ok/681K6du0OOXxGQ==
alias b=bun

fnm env | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

starship init fish | source

export XDG_CONFIG_HOME=/Users/haukeschnau/.config

set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
carapace _carapace | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/miniconda3/bin/conda
    eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/miniconda3/etc/fish/conf.d/conda.fish"
        . "/opt/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

function rga-fzf
    set RG_PREFIX 'rga --files-with-matches'
    if test (count $argv) -gt 1
        set RG_PREFIX "$RG_PREFIX $argv[1..-2]"
    end
    set -l file $file
    set file (
        FZF_DEFAULT_COMMAND="$RG_PREFIX '$argv[-1]'" \
        fzf --sort \
            --preview='test ! -z {} && \
                rga --pretty --context 5 {q} {}' \
            --phony -q "$argv[-1]" \
            --bind "change:reload:$RG_PREFIX {q}" \
            --preview-window='50%:wrap'
    ) && \
    echo "opening $file" && \
    open "$file"
end

fzf --fish | source
export FZF_ALT_C_OPTS="--preview 'ls --tree {} | head -200'"

