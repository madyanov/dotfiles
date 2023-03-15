autoload -Uz compinit && compinit
zstyle :compinstall filename "$HOME/.zshrc"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt PROMPT_SUBST

# Prompt
precmd() { precmd() { echo; } }
PROMPT="%F{red}%n%f in %B%F{yellow}%~%f%b"$'\n'"%F{%(?.white.red)}%#%f "
git_branch() { git rev-parse --git-dir > /dev/null 2>&1 && git rev-parse --abbrev-ref HEAD 2> /dev/null; }
RPROMPT="%B%F{green}\$(git_branch)%f%b"

# Environment
export CLICOLOR=1
export EDITOR=nvim

# Dotfiles
# first initialize bare repository with `git init --bare "$HOME/.dotfiles"`
# or clone it with `git clone --bare git@gitlab.com:madyanov/dotfiles.git "$HOME/.dotfiles"`
# then hide untracked files with `dotfiles config status.showUntrackedFiles no`
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'

# Aliases
alias vim="nvim"
alias vimdiff="nvim -d"
alias mc="mc --nosubshell"
alias dev='cd "$HOME/Development"'

# Functions
togif() {
    local in=$1
    local out=$2
    ffmpeg -i "$in" -pix_fmt rgb8 -r 10 "$out" && gifsicle -O3 "$out" -o "$out"
}

cleanup() {
    if command -v pacman &> /dev/null; then
        set -x
        sudo pacman -Qqd | sudo pacman -Rsu -
        sudo paccache -rvk1
        sudo paccache -rvuk0
        sudo pacman -Sc
        set +x
    fi

    if command -v paru &> /dev/null; then
        set -x
        paru -Sc
        set +x
    fi

    if command -v brew &> /dev/null; then
        set -x
        brew autoremove
        brew cleanup
        set +x
    fi
}
