# Zsh reads $ZDOTDIR/.zshenv instead of ~/.zshenv whenever ZDOTDIR is already set, which is the case
# for every nested shell (it is exported by ~/.zshenv). Without this file those shells would miss
# skip_global_compinit and the XDG defaults, so delegate to the single source of truth.
source "$HOME/.zshenv"
