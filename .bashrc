# ~/.bashrc: executed by bash(1) for non-login shells.

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

alias files='cut -d: -f1 | uniq'
alias d='docker'
alias dc='docker-compose'
alias dm='docker-machine'
alias ls='ls -ahF'
alias :e="nvim"
alias :v="tmux split-window -h nvim"
alias :s="tmux split-window -v nvim"

tnjq() {
    jq -r .msg | jq -r '.log|rtrimstr("\n")' | jq "$@"
}

PSCOLOR=$(if [ "$USER" == "root" ]; then echo -n 31; else echo -n 33; fi)

PS1='\[\033[01;34m\]''\W '"\[\033[1;${PSCOLOR}m\]❯\[\033[00;37m\] "

ran() {
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

git-repush() {
    git br -D "$1" &&
    git br "$1" &&
    git push origin "$1" -f
}

export EDITOR=vim
export PAGER=less
export LESS="-SMRci"

export GOPATH="${HOME}"/gocode
export CPLUS_INCLUDE_PATH="/usr/local/include:${CPLUS_INCLUDE_PATH}"
export PATH=\
/sbin:\
/bin:\
${GOPATH}/bin:\
/usr/local/sbin:\
/usr/local/bin:\
/usr/sbin:\
/usr/bin:\
/Developer/usr/bin:\
${HOME}/bin:\
${HOME}/FlameGraph:\
${HOME}/.yarn/bin:\
/Applications/Inkscape.app/Contents/Resources/bin:\
/usr/local/opt/go/libexec/bin

# git bash completion
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    source /usr/local/etc/bash_completion.d/git-completion.bash
elif [ -f /usr/local/share/git-core/git-completion.bash ]; then
    source /usr/local/share/git-core/git-completion.bash
fi

# brew completion
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
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

# if which nvim > /dev/null; then
#     alias vim='nvim'
# fi

setup-fasd() {
    if which fasd > /dev/null; then
        fasd_cache="$HOME/.fasd-init-bash"
        if [ "$(command -v fasd)" -nt "$fasd_cache" ] || [ ! -s "$fasd_cache" ]; then
            fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
        fi
        source "$fasd_cache"
        unset fasd_cache
    fi
}

z() {
    unset z
    setup-fasd
    fasd_cd -d "$@"
}

export GO15VENDOREXPERIMENT=1

# added by travis gem
[ -f /Users/kris/.travis/travis.sh ] && source /Users/kris/.travis/travis.sh

# d=$(test -f /tmp/wat.txt && cat /tmp/wat.txt || echo 0.1)
# (sleep "$d" && echo "$d + 0.1") | bc > /tmp/wat.txt
