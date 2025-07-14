# Load Oh My Zsh configuration
source "${0:A:h}/init/oh_my_zsh"

# Load zsh file loader
source "${0:A:h}/init/loader"

# Load history utilities
source "${0:A:h}/init/history_clean"
source "${0:A:h}/init/history_write"

# 既存の Ctrl+  を無効化(-r)
bindkey -r '^R'
bindkey -r '^S'  # incremental search

# Set colors of files
eval $(dircolors ~/.dircolors)

# Set prompt: display current directory in blue(33) and end with $ (user) or # (root).
PS1='%F{33}%1~%f %# '

### autocomplete ###
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

# gcloud
source /usr/share/google-cloud-sdk/completion.zsh.inc

# Terraform
complete -o nospace -C /usr/bin/terraform terraform

# Case insensitive for completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

### BELOW ARE FOR APPLICATIONS ###

# fzf
source "${0:A:h}/init/fzf_helper"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm use default >/dev/null

autoload -Uz add-zsh-hook
# add-zsh-hook precmd set_prompt
