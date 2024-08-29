# What

- Slitted zsh files for `.zshrc`.
- Create `.zshrc file` below and source each zsh file.
- Create `profile.zsh` for environmental variables and `alias.zsh`
  for the project specific commands alias.
- Sensitive files like profile.zsh and alias.zsh should be in `.gitignore`.

`.zshrc`
```sh
# ~/.zsh.d内にある*.zshという名称のファイルを読み込んでくれるので
# alias.zshなどというファイル名で中身は通常通りzshの設定を記述
# https://fnwiya.hatenablog.com/entry/2015/11/03/191902

### split zsh
ZSHHOME="${HOME}/.zsh.d"

if [ -d $ZSHHOME -a -r $ZSHHOME -a \
     -x $ZSHHOME ]; then

    # Source the .profile.zsh file first
    profile_zsh="$ZSHHOME/profile.zsh"
    if [ -f "$profile_zsh" -o -h "$profile_zsh" ] && [ -r "$profile_zsh" ]; then
        . "$profile_zsh"
    fi

    # Source the remaining zsh files
    for i in $ZSHHOME/*; do
        if [ "$i" != "$profile_zsh" ]; then
          [[ ${i##*/} = *.zsh ]] && [ \( -f $i -o -h $i \) -a -r $i ]  && . $i
        fi
    done
fi
### split zsh

# Set colors of files
eval $(dircolors ~/.dircolors)

# Set prompt: display current directory in blue(33) and end with $ (user) or # (root).
PS1='%F{33}%1~%f %# '

### autocomplete
autoload -U bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

# Case insensitive for completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Set completion
compdef g=git
### autocomplete
# # ----- echo date when execute -----
# function preexec_function1() {
#   echo -e "\033[1;32m$(date +%m/%d\ %H:%M:%S)\033[0m"
# }
# autoload -Uz add-zsh-hook
# add-zsh-hook preexec preexec_function1zrs
# # ----- echo date when execute -----

# Init fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH":~/.local/bin

```

`profile.zsh`
```sh
# export SOME_ENV=my_env
```
