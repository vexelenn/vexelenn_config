# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="amuse"  # Use the amuse theme

# Uncomment for features
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# DISABLE_UPDATE_PROMPT="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"

# Use custom plugins
plugins=(
  git
  bundler
  dotenv
  macos
  tmux
  pip
  virtualenvwrapper
  command-not-found
  vi-mode
  ssh-agent
)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# ====================
# ENVIRONMENT SETTINGS
# ====================
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export WORKON_HOME="$HOME/venvs"

# Path extensions
export VIM_HOME="/opt/homebrew/Cellar/vim/9.1.0650/"
export NVM_DIR="$HOME/.nvm"
export PATH=$PATH:$VIM_HOME/bin:$HOME/.local/bin:$HOME/Library/Python/3.13/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

# Load NVM if installed
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# ====================
# ZSH OPTIONS
# ====================
setopt no_beep
setopt notify
setopt noflowcontrol
stty -ixon -ixoff
setopt nohup
setopt inc_append_history
setopt share_history
setopt prompt_subst

# ====================
# VI MODE INDICATOR
# ====================
vim_ins_mode="%{$fg[cyan]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg[green]%}[CMD]%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}

# ====================
# ALIASES
# ====================
alias ll='ls -al'
alias l='ls -l'
alias sl='ls'
alias cd..='cd ..'
alias egpt="sgpt --model gpt-4.5-preview --role exec --repl"
alias ansible_fast_tests="py.test -x -m 'not slow' -k 'not test_build_lambda_script'"

# Shell-GPT ZSH integration
_sgpt_zsh() {
  if [[ -n "$BUFFER" ]]; then
    _sgpt_prev_cmd=$BUFFER
    BUFFER+="⌛"
    zle -I && zle redisplay
    BUFFER=$(sgpt --shell <<< "$_sgpt_prev_cmd" --no-interaction)
    zle end-of-line
  fi
}
zle -N _sgpt_zsh
bindkey ^l _sgpt_zsh

# ====================
# FZF Integration
# ====================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ====================
# ZPLUG (optional)
# ====================
if [ -f ~/.zplug/init.zsh ]; then
  source ~/.zplug/init.zsh
  zplug "zplug/zplug"
  zplug "robbyrussell/oh-my-zsh", use:oh-my-zsh.sh, nice:-10

  # Ensure oh-my-zsh plugins via zplug are loaded too (redundant if using plugins= above directly)
  # zplug "plugins/git",   from:oh-my-zsh
  # zplug "plugins/tmux", from:oh-my-zsh

  zplug "supercrabtree/k"
  zplug "halfo/lambda-mod-zsh-theme"
  
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi
  zplug load --verbose
fi

