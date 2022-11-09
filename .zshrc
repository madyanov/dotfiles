autoload -Uz compinit && compinit

setopt HIST_IGNORE_DUPS
setopt PROMPT_SUBST

# Prompt
precmd() { precmd() { echo; } }
git_branch() { git rev-parse --abbrev-ref HEAD 2> /dev/null; }
PROMPT="%F{red}%n%f in %B%F{yellow}%~%f%b"$'\n'"%F{%(?.white.red)}%#%f "
RPROMPT="%B%F{green}\$(git_branch)%f%b"

# Environment
export CLICOLOR=1
export EDITOR=nvim

# Dotfiles
# first initialize bare repository with `git init --bare $HOME/.dotfiles`
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no

# Aliases
alias vim="nvim"
alias mc="mc --nosubshell"

# Functions
togif() {
    local in=$1
    local out=$2
    ffmpeg -i "$in" -pix_fmt rgb8 -r 10 "$out" && gifsicle -O3 "$out" -o "$out"
}
