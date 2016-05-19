# ~/.bashrc: executed by bash(1) for non-login shells.

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

alias files='cut -d: -f1 | uniq'

function tnjq {
    jq -r .msg | jq -r '.log|rtrimstr("\n")' | jq $@
}

PSCOLOR=$(if [ "$USER" == "root" ]; then echo -n 31; else echo -n 33; fi)
PS1=\
'\[\033[01;32m\]'\
'\u@\h'\
'\[\033[00m\]'\
':'\
'\[\033[01;34m\]'\
'\w'\
'\[\033[00m\]'\
" \[\033[1;${PSCOLOR}m\]❯❯\[\033[00;37m\] "

if [ "$PRESO" ]; then
    PS1='\[\033[01;34m\]''\w '"\[\033[1;${PSCOLOR}m\]❯❯\[\033[00;37m\] "
fi

function ran() {
    man -k . | awk '
        BEGIN {srand()}
        {
            cur = substr($1, 0, index($1, "(")-1);
            score = rand();
            if (score > last_score) {
                last_score = score;
                last = cur;
            }
        }
        END {print last}
    ' | xargs man
}

bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

export EDITOR=vim
export PAGER=less
export LESS="-SMRci"

export GOPATH="${HOME}"/gocode
export CPLUS_INCLUDE_PATH="/usr/local/include:${CPLUS_INCLUDE_PATH}"
export PATH=\
/sbin:\
/bin:\
/usr/local/sbin:\
/usr/local/bin:\
/usr/sbin:\
/usr/bin:\
/Developer/usr/bin:\
${HOME}/bin:\
${GOPATH}/bin

# git bash completion
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    source /usr/local/etc/bash_completion.d/git-completion.bash
fi
if [ -f /usr/local/share/git-core/git-completion.bash ]; then
    source /usr/local/share/git-core/git-completion.bash
fi

# brew completion
if which brew && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion"
fi

# added by travis gem
if [ -f "$HOME"/.travis/travis.sh ]; then
    source "$HOME"/.travis/travis.sh
fi

# added by nvm
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
fi

# local overrides
if [ -f "$HOME"/.bashrc.local ]; then
    source "$HOME"/.bashrc.local
fi
