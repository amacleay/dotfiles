# Nice-to-have interactive commands

alias ggl="git checkout -- Gemfile*.lock"

# Save a very long command history, ignore lines starting with space, append immediate
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoreboth
shopt -s histappend
PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"

# Nice output
export CLICOLOR=1
alias ls='ls --color=always'
alias grep='grep --color=always'
export PAGER='less -RS'

if [ -t 1 ]; then
  bind 'set completion-ignore-case On'
fi

# tmuxr
# tmux-reattach - looks to see if session is running and attaches if it is, else creates new with that name
function tmuxr {
  if [ "$1" ]; then
    if [[ -z $( tmux list-sessions -F '#{session_name}' 2>/dev/null | grep $1 ) ]]; then
      tmux_new_session $*
    else
      tmux attach-session -d -t $1;
    fi;
  else
    echo 'Need first argument to be session name';
    return 2;
  fi
}

# Creates a new tmux session with a given name.  First parameter is session name, second parameter
# is an enum specifying a type of session to start.  Current values:
function tmux_new_session {
  if [ "$1" ]; then
    if [ "$2" ]; then
      case $2 in
        # left as example
        [Cc][Pp])
#          aws-vault exec prod -- echo CloudPercept session starting;
          tmux new -s $1 -n runners -d

          # Split first window into four rectangles:
          # 0 1
          # 2 3
          tmux split-window -t "$1:0"
          tmux split-window -h -t "$1:0.0"
          tmux split-window -h -t "$1:0.2"

          # Load up default commands, but don't yet execute:
          # shell takes a moment to get prepared
          tmux send-keys -t "$1:0.0" 'echo hi'
          tmux send-keys -t "$1:0.1" 'echo hi'
          tmux send-keys -t "$1:0.2" 'echo hi'
          tmux send-keys -t "$1:0.3" 'echo hi'

          echo 'Loading shells...'
          sleep 1
          tmux send-keys -t "$1:0.0" Enter
          tmux send-keys -t "$1:0.1" Enter
          tmux send-keys -t "$1:0.2" Enter
          tmux send-keys -t "$1:0.3" Enter

          tmux attach-session -d -t $1;
          cd -;
          ;;

        *)
          tmux new -s $1
          ;;
      esac
    else
      tmux new -s $1;
    fi
  else
    echo 'Need first argument to be session name';
    return 2;
  fi
}

source ~/.bash_git_ps1

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export EDITOR=vim

alias gbr="git branch | grep '*' | cut -d' ' -f2"
