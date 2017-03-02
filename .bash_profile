# ~/.bashrc: executed by bash(1) for login shells.

bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

if [ -f "$HOME/.bashrc" ]; then
    # shellcheck disable=SC1090
    source "$HOME/.bashrc"
fi

# added by Nix installer
if [ -e "$HOME"/.nix-profile/etc/profile.d/nix.sh ]; then
    . "$HOME"/.nix-profile/etc/profile.d/nix.sh
fi

# local overrides
if [ -f "$HOME"/.bash_profile.local ]; then
    # shellcheck disable=SC1090
    source "$HOME"/.bash_profile.local
fi
