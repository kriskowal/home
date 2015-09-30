# ~/.bashrc: executed by bash(1) for login shells.
if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi

# local overrides
if [ -f "$HOME"/.bash_profile.local ]; then
    source "$HOME"/.bash_profile.local
fi
