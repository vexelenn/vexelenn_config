# Path to your oh-my-zsh installation.
export ZSH=/home/vexelenn/.oh-my-zsh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)

# User configuration

export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/vexelenn/bin:/usr/local/java/jdk1.8.0_91/bin:/home/vexelenn/bin:/usr/local/java/jdk1.8.0_91/bin
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'
export VISUAL=vim
export PAGER=less

# zsh will not beep
setopt no_beep

# Report the status of background jobs immediately, rather than waiting until just before printing a prompt.
setopt notify

# Turn off terminal driver flow control (CTRL+S/CTRL+Q)
setopt noflowcontrol
stty -ixon -ixoff

# Do not kill background processes when closing the shell.
setopt nohup

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# export "TERM=tmux-256color"
source ~/.zplug/init.zsh

setopt inc_append_history
setopt share_history

zplug "zplug/zplug"

zplug "robbyrussell/oh-my-zsh", use:oh-my-zsh.sh, nice:-10
# zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh", nice:-1

zplug "plugins/git",   from:oh-my-zsh, if:"which git"

zplug "plugins/tmux", from:oh-my-zsh

export WORKON_HOME="$HOME/venvs"
zplug "plugins/virtualenvwrapper", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh

zplug "plugins/command-not-found", from:oh-my-zsh

zplug "supercrabtree/k"
zplug "plugins/ssh-agent", from:oh-my-zsh

setopt prompt_subst # Make sure propt is able to be generated properly.
zplug "halfo/lambda-mod-zsh-theme" # , use:"lambda-mod.zsh-theme"

zplug "plugins/vi-mode", from:oh-my-zsh
bindkey -M viins 'kj' vi-cmd-mode
bindkey -M viins 'jk' vi-cmd-mode

# taken from http://pawelgoscicki.com/archives/2012/09/vi-mode-indicator-in-zsh-prompt/
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

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
# Thanks Ron! (see comments)
function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}
# thanks Pawel:-)

# ALIASES

# ls
alias ll='ls -al'
alias l='ls -l'
alias sl=ls

alias cd..='cd ..'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

export VAGRANT_DEFAULT_PROVIDER="lxc"

# RPROMPT='${vim_mode}'

# alias for ansible
alias ansible_fast_tests="py.test -x -m 'not slow' -k 'not test_build_lambda_script'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="/home/vexelenn/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export JIRA_USERNAME="l.malecki@clearcode.cc"
export JIRA_PASSWORD="1234lucas"
alias release.py=/home/vexelenn/venvs/release_py/bin/release.py
