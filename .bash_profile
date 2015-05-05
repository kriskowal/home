# ~/.bashrc: executed by bash(1) for login shells.
source .bashrc

# local overrides
if [ -f "$HOME"/.bash_profile.local ]; then
    source "$HOME"/.bash_profile.local
fi
