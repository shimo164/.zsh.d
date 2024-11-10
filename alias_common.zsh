# ----- Common alias for all profjects. -----

alias python='python3'
alias pip='pip3'

# ignore $ at the beggining of the command
alias \$=''

# A trailing space in VALUE causes the next word to be checked for alias substitution when the alias is expanded.
alias sudo='sudo '

# cd to history path. Used with cd_history.zsh.
alias cc='cd_history'

alias a='cd ..'
alias aa='cd ../..'
alias aaa='cd ../../..'

alias ls='ls --color=auto'
alias ll='ls -ltrh'
alias lla='ls -ltrha'
alias lld='du -hs $(ls -AF) | sort --human-numeric-sort'  # sort by numrica value
alias llt='du -hs --time $(ls -AF) | sort -k 2,2'  # sort by time

alias g='git'
alias ga='git add .'
alias gb='git branch'
alias gbr='git branch'
alias gc='git checkout'
alias gch='git checkout'
alias gco='git commit -m '
alias gcm='git commit -m '
alias gp='git pull'
alias gs='git status'
alias gst='git status'
alias glo='git log --oneline -n 5'
alias gloo='git log -n 1'

alias ff='bash $SCRIPTS/fzf_alias_commands.sh'
alias gg='bash $SCRIPTS/git_branch_checkout.sh'

alias zrc='bash $SCRIPTS/open_zsh_files.sh'
alias zrs='source ~/.zshrc'

# Use trash-cli instead of rm
alias rm='echo "This is not the command you are looking for. Use 'trash'."; false'

# expand alias with space key
function expand-alias() {
	zle _expand_alias
	zle self-insert
}
zle -N expand-alias
bindkey -M main ' ' expand-alias

## Use if needed
# alias dcd='docker-compose down'
# alias dcu='docker-compose up'
# alias isort2='isort --multi-line 2 --line-length 110 --combine-as '
# alias pt='pytest -p no:warnings -s --tb=short --no-header'
# alias rmnode='rm -rf node_modules/'
