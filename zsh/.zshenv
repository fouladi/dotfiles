export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Ubuntu's /etc/zsh/zshrc runs its own compinit before ours. That doubles the
# work and, because fpath differs between the two calls, forces a full rebuild
# of the completion dump on every shell start. We run compinit in .zshrc.
skip_global_compinit=1
