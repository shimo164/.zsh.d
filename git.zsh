show_current_branch_and_stash() {
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    echo Current branch: $current_branch
    git stash list
    echo
}

get_stash_number_and_message() {
    # $1: stash@{n} or stash@{n} or stash@{n}

    STASH_NUM=$(echo $@ | sed -n 's/^stash@{*\([0-9]*\)}/\1/p')
    if [ -z "$STASH_NUM" ]; then
      STASH_NUM=0
    fi

    STASH_MSG=$(git stash list | grep "stash@{${STASH_NUM}}" | awk -F": " '{print $3}')

    echo "$STASH_NUM" "$STASH_MSG"
}


prompt_and_execute_command() {
    # If user inputs 'y', then execute command
    # If user inputs 'n', then abort
    # If user inputs other, then prompt again
    # $1: prompt message
    # $2: command to execute

    local prompt_message=$1
    local command_to_execute=$2
    echo $prompt_message
    echo $command_to_execute

    while true; do
        echo -n "$prompt_message [y/N]: "
        read ANS
        case $ANS in
            [Yy]* )
                eval "command $command_to_execute"
                return 0
                ;;
            [Nn]* )
                echo "Abort..."
                return 1
                ;;
            * )
                ;;
        esac
    done
}


# Avoid git accidentally
git() {
  if [[ $1 == "stash" && $2 == "pop" ]]; then

    show_current_branch_and_stash
    read STASH_NUM STASH_MSG <<< $(get_stash_number_and_message $3)
    prompt_and_execute_command \
    "pop stash@{${STASH_NUM}} ${STASH_MSG}. OK?" \
    "git stash pop stash@{${STASH_NUM}}"

  elif [[ $1 == "stash" && $2 == "apply" ]]; then

    read STASH_NUM STASH_MSG <<< $(get_stash_number_and_message $3)
    prompt_and_execute_command \
    "apply stash@{${STASH_NUM}} ${STASH_MSG}. OK?" \
    "git stash apply stash@{${STASH_NUM}}"

  elif [[ $@ == "stash clear" ]]; then
    show_current_branch_and_stash
    prompt_and_execute_command \
    "CLEAR git stash OK?" \
    "git stash clear"

  elif [[ $@ == "stash" ]]; then
    local current_date=$(date +"%m/%d %H:%M")
    local command_to_execute="git stash save -u \"${current_date}\""
    prompt_and_execute_command \
    "Are you sure to save stash with comment?" \
    "$command_to_execute"

 elif [[ $1 == "reset" ]]; then
    local command_to_execute="git ${@}"
    prompt_and_execute_command \
    "Are you sure you want to execute '${command_to_execute}'?" \
    "$command_to_execute"

  else
    # Execute other git commands
    command git "$@"
  fi
}
