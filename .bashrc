# ~/.bashrc: executed by bash(1) for non-login shells.

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

PSCOLOR=$(if [ "$USER" == "root" ]; then echo -n 31; else echo -n 33; fi)

PS1=\
'${debian_chroot:+($debian_chroot)}'\
'\[\033[01;32m\]'\
'\u@\h'\
'\[\033[00m\]'\
':'\
'\[\033[01;34m\]'\
'\w'\
'\[\033[00m\]'\
" \[\033[1;${PSCOLOR}m\]❯❯\[\033[00;37m\] "

# git bash completion
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    source /usr/local/etc/bash_completion.d/git-completion.bash
fi

bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

export PATH=\
${HOME}/bin:\
/usr/local/sbin:\
/usr/local/bin:\
/usr/sbin:\
/usr/bin:\
/sbin:\
/bin:\
/Developer/usr/bin

export PAGER=less
export EDITOR=vim

# add user bin dir
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

# added by travis gem
[ -f /Users/kris/.travis/travis.sh ] && source /Users/kris/.travis/travis.sh

# added by nvm
export NVM_DIR="/Users/kris/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
