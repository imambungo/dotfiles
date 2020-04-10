#!/usr/bin/env bash

if [[ "$TMUX" == "" ]]
then
	# not on tmux
	tmux
	exit
fi
