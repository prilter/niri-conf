export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="nicoulaj" # arrow bureau cypher fino-time gnzh half-life jnrowe linuxonly nicoulaj kardan
alias v='vino'
alias rm='rm -rf'

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  colored-man-pages
  zsh-vi-mode
  fzf-tab
)

source $ZSH/oh-my-zsh.sh
export MANPATH="/usr/local/man:$MANPATH"
export EDITOR=nvim # for ranger

source /home/max/.config/broot/launcher/bash/br
