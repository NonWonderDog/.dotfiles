#!/bin/bash
# ~/.bash_profile: executed by bash(1) for login shells.

# include .bashrc
# msysgit does this automatically out of pure condescension, so check that it 
# hasn't already been sourced.
if [ -f ~/.bashrc ]; then
    if [ -z ${BASHRC+x} ]; then
        source ~/.bashrc
    fi
    unset BASHRC
fi

# set PATH to include private bin
if [ -d ~/bin ]; then
    PATH="~/bin:$PATH"
fi

