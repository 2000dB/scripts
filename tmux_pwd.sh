#!/bin/bash

# Tmux pwd update
if [ -n "$TMUX" ]; then
    f() {
	if [ "$PWD" != "$LPWD" ];then
	    LPWD="$PWD";
	    tmux rename-window ${PWD//*\//};
	fi };
    export PROMPT_COMMAND=f;
fi

