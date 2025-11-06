# Runs only at Login

# --- Pyenv setup ---
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# --- Path configuration ---
setopt extended_glob    # advanced globbing
setopt null_glob        # empty expansion instead of literal pattern

path=(
  $path
  .
  $HOME/bin
  $HOME/.local/bin
  $HOME/.cargo/bin
  $HOME/.go/bin
  /usr/local/bin
)

# Remove duplicates and non-existent directories
typeset -U path
path=($^path(N-/))
export PATH

# --- Go environment ---
export GOPATH="$HOME/.go"

# --- Misc environment variables ---
export EDITOR='nvim'
export DNHOME="$HOME/repo/doc/daily_notes"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# --- LS_COLORS via vivid ---
export LS_COLORS="$(vivid generate gruvbox-dark)"

# --- Optional: backward compatibility with ~/.profile ---
[[ -f ~/.profile ]] && source ~/.profile
