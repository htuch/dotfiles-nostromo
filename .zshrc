#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Load zsh-autosuggestions, fish-like predictive typeahead.
source ~/.zsh/zsh-autosuggestions/autosuggestions.zsh

# zsh-bd, quick parent directory traversal.
source ~/.zsh/zsh-bd/bd.zsh

# Enable autosuggestions automatically.
zle-line-init() {
  zle autosuggest-start
}
zle -N zle-line-init

# Jump forward a word or to end of the line in insert mode
bindkey '^f' vi-forward-blank-word
bindkey '^e' end-of-line

# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD

# 10 second wait if you do something that will delete everything.
#setopt RM_STAR_WAIT

# Maintain bounded stack of recent history (i.e. pushd by default)
# Supports dh and cd -N workflow
export DIRSTACKSIZE=8
setopt AUTO_PUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
alias dh='dirs -v'

# Clear line on q in edit mode
bindkey -M vicmd 'q' push-line

# Nice behavior for globs and history expansions
setopt EXTENDED_GLOB GLOB_COMPLETE
bindkey -M viins ' ' magic-space

# History search in both insert and command modes
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd '?' history-incremental-search-forward
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M viins '^s' history-incremental-search-forward

# No bell
setopt NOBEEP

# Share history between sessions
setopt SHARE_HISTORY

# Print exit value on failure
setopt PRINT_EXIT_VALUE

# Allow commands like "git show HEAD^" to work with glob match fails
setopt NO_NOMATCH

# Pipe into a local variable, e.g. ps aux | k; echo $kept
keep() {
        local line IFS=$'\n'
        kept=
        while read -r line; do
                printf '%s\n' "$line"
                kept=$kept$line$IFS
        done
}
alias k='keep'

# Single tab completion behavior ala bash
unsetopt LISTAMBIGUOUS

# Terminal color space
ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}

# Show all 256 colors with color number
function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}$ZSH_SPECTRUM_TEXT%f"
  done
}

# Show all 256 colors where the background is set to specific color
function spectrum_bls() {
  for code in {000..255}; do
    print -P -- "$BG[$code]$code: $ZSH_SPECTRUM_TEXT %{$reset_color%}"
  done
}

# Helpful aliases
alias gr='git gr'

alias -s c=vim
alias -s py=vim
alias -s md=vim
alias -s log='less -N'

source ~/.zshrc.local