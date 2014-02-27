# Use tmux to connect open multiple ssh connections
# first arg is the session name

USER="root"
DOMAIN=".local"

starttmux() {
    echo $HOSTS
    if [ -z "$HOSTS" ]; then
        echo -n "Please provide of list of hosts separated by spaces [ENTER]: "
        read HOSTS
    fi
    
    tmux new-session -d -s $sessionname
    for i in $HOSTS
    do
        tmux split-window -t $sessionname -h
        tmux send-keys -t $sessionname "ssh $USER@$i$DOMAIN" Enter
        tmux select-layout -t $sessionname tiled
    done

    tmux kill-pane -t $sessionname.0
    tmux select-pane -t $sessionname.0
    tmux attach -t $sessionname
    tmux select-layout -t $sessionname tiled
    tmux set-window-option synchronize-panes on
}

BNAME=`basename $0`
if  [ $# -lt 1 ]; then
    exit 0
fi

sessionname=$1
starttmux
