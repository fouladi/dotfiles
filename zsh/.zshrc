# ------------- Shell options
setopt extended_glob           # Advanced globbing (e.g., ^, ~, # qualifiers)
setopt null_glob               # Empty expansion instead of error on no match
setopt interactivecomments     # Allow comments (#) in interactive shell

# ------------- Path configuration
# Zsh keeps 'path' (array) and 'PATH' (scalar) in sync automatically.
path=(
  $path                        # Preserve existing PATH entries
  .
  $HOME/bin
  $HOME/.local/bin
  $HOME/.cargo/bin             # Rust toolchain binaries
  $HOME/.go/bin                # Go compiled binaries
  /usr/local/bin
)

# Remove duplicate entries and prune non-existent directories
typeset -U path
path=($^path(N-/))

export PATH

# ------------- Go environment
export GOPATH="$HOME/.go"

# ------------- Environment variables
export EDITOR='nvim'
export DNHOME="$HOME/repo/doc/daily_notes"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export LS_COLORS="$(vivid generate gruvbox-dark)"

# Zinit Plugin Manager
#
# Zinit is a flexible and fast Zsh plugin manager. It supports turbo mode
# (deferred loading) to keep shell startup snappy.
# Repository: https://github.com/zdharma-continuum/zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
#
# Plugins use "turbo mode" (wait lucid) where possible, meaning they load
# asynchronously after the first prompt is drawn — faster perceived startup.

# --- zsh-completions ---
# Adds ~300 additional completion definitions for common tools (docker, cargo,
# fd, rg, etc.) not included in Zsh by default.
# 'blockf' prevents the plugin from modifying fpath at source time — we handle
# fpath ourselves before compinit.
zinit ice blockf
zinit light zsh-users/zsh-completions

# --- zsh-syntax-highlighting ---
# Highlights commands as you type: valid commands in green, errors in red,
# strings, options, and paths each get distinct colors.
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

# --- zsh-autosuggestions ---
# Shows a dimmed suggestion of the most recent matching history entry as you
# type. Accept with → (right arrow) or End key.
zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# --- fzf-tab ---
# Replaces the default completion menu with fzf (fuzzy finder). Allows fuzzy
# matching, preview panes, and multi-select in tab completion.
zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# --- zsh-history-substring-search ---
# Adds Up/Down arrow history search by substring. Type a partial command, then
# press Up to cycle through matching history entries. Without typed text, it
# behaves like normal history navigation.
# Keybindings are set in atload to ensure the widget exists before binding.
# Both ^[[A/B (normal mode) and ^[OA/B (application mode) are bound for
# Ghostty compatibility.
zinit ice wait lucid atload"
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^[OA' history-substring-search-up
  bindkey '^[OB' history-substring-search-down
"
zinit light zsh-users/zsh-history-substring-search

# Oh My Zsh Snippets
#
# These are individual files/plugins from Oh My Zsh, loaded without the full
# OMZ framework overhead.

zinit snippet OMZL::git.zsh            # Git library (core git functions used by OMZP::git)
zinit snippet OMZP::git                # Git aliases (gst, gco, gp, gl, etc.)
zinit snippet OMZP::sudo              # Press ESC twice to prepend 'sudo' to current/last command
zinit snippet OMZP::virtualenv        # Show active Python virtualenv in prompt
zinit snippet OMZP::uv                # Completions for the 'uv' Python package manager
zinit snippet OMZP::colorize          # Syntax-highlight file contents via 'ccat' / 'cless'
zinit snippet OMZP::extract           # Universal 'extract' command for any archive type
zinit snippet OMZP::zoxide            # Integration helpers for zoxide (smart cd)
zinit snippet OMZP::command-not-found # Suggests package to install when command is missing

# ------------- Load completions
# compinit initializes the completion system. Must run after plugins that add
# completion definitions (like zsh-completions) have populated fpath.
autoload -Uz compinit && compinit

# Replay completions that zinit captured during turbo loading
zinit cdreplay -q

# History
#
HISTSIZE=10000                 # Max entries kept in memory
HISTFILE=~/.zsh_history        # Persistent history file
SAVEHIST=$HISTSIZE             # Max entries saved to HISTFILE
HISTDUP=erase                  # Remove older duplicate when new duplicate is added
setopt appendhistory           # Append to history file (don't overwrite)
setopt sharehistory            # Share history across all active sessions
setopt hist_ignore_space       # Commands starting with space are not recorded
setopt hist_ignore_all_dups   # Remove ALL older duplicates of a new entry
setopt hist_save_no_dups      # Don't write duplicates to HISTFILE
setopt hist_find_no_dups      # Skip duplicates when searching history (Ctrl+R)

# Completion Styling
#
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'   # Case-insensitive matching
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # Color completions like ls
zstyle ':completion:*' menu no                            # Disable default menu (fzf-tab handles it)
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'          # Preview dirs on cd
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'  # Preview dirs on z/cd

# ============================================================================
# Daily Notes (dn) — lightweight CLI note-taking
# ============================================================================
# Files are stored as plain text in $DNHOME with date-based filenames.

# 'dn' — append a bullet point to today's note file
dn() {
  echo " * $1" >> $DNHOME/$(date "+%Y-%m-%d")
}

# 'dno' — append a bullet to a specific date file (e.g., dno 2030-10-01 "Mars Flight")
dno() {
  echo " * $2" >> $DNHOME/"$1"
}

# 'dnt' — display today's notes
dnt() {
  echo $(date "+%Y-%m-%d")
  cat $DNHOME/$(date "+%Y-%m-%d")
}

# 'dnview' — display notes for a date prefix (e.g., dnview 2024-03)
dnview() {
  find $DNHOME/"$1"* -type f -exec basename {} \; -exec cat {} \;
}

# 'dna' — archive notes for a date prefix into a single markdown file
dna() {
  find $DNHOME/"$1"* -type f -exec basename {} \; -exec cat {} \; > $DNHOME/archive/"$1".md
  sed -i -e 's/^20/\n## 20/' $DNHOME/archive/"$1".md
}

# 'dntodo' — add a TODO item to this month's TODO file
dntodo() {
  _FILENAME=$DNHOME/TODO-$(date "+%Y-%m").md
  if [[ ! -e $_FILENAME ]]; then
    echo "### $(date "+%Y-%m")" > "$_FILENAME"
  fi
  echo "- [ ] $1" >> "$_FILENAME"
}

# ============================================================================
# Keybindings
# ============================================================================
source ~/.alias.zsh

# --- Yazi file manager wrapper ---
# Launches yazi and changes CWD to its exit directory (press q).
# Press Q to quit without changing directory.
y() {
  local tmp="$(mktemp -t 'yazi-cwd.XXXXXX')" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Use emacs keybinding mode (Ctrl+A, Ctrl+E, Ctrl+K, etc.)
bindkey -e

# Make ALT+BACKSPACE stop at non-alphanumeric characters (Bash-like behavior)
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
    zle -f kill
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

# Terminal key bindings (Ghostty / xterm-compatible escape sequences)
bindkey "^[[H" beginning-of-line       # Home
bindkey "^[[F" end-of-line             # End
bindkey "^[[2~" overwrite-mode         # Insert (toggle)
bindkey "^[[3~" delete-char            # Delete
bindkey "^[[5~" up-line-or-history     # PageUp
bindkey "^[[6~" down-line-or-history   # PageDown

# ============================================================================
# FZF Options
# ============================================================================
# Ctrl+T: file picker with bat preview
export FZF_CTRL_T_OPTS=" --walker-skip .git,node_modules,target --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Alt+C: directory picker with tree preview
export FZF_ALT_C_OPTS=" --walker-skip .git,node_modules,target --preview 'tree -C {}'"

# ============================================================================
# Python Virtual Environment Auto-Activation
# ============================================================================
# Automatically activates .venv when entering a directory that contains one,
# and deactivates when leaving (only if a venv is currently active).
python_venv() {
  MYVENV=./.venv
  if [[ -d $MYVENV ]]; then
    source $MYVENV/bin/activate > /dev/null 2>&1
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    deactivate > /dev/null 2>&1
  fi
}
autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv
python_venv  # Run once at shell start for current directory

# ============================================================================
# Tool Initialization (cached for faster startup)
# ============================================================================
# Instead of running `eval "$(tool init zsh)"` on every shell start (which
# forks a subprocess each time), we cache the output to a file and source it.
# The cache is invalidated automatically when the tool binary is updated.
_zsh_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d "$_zsh_cache_dir" ]] || mkdir -p "$_zsh_cache_dir"

_cache_eval() {
  local name="$1" cmd="$2"
  local cache_file="$_zsh_cache_dir/$name.zsh"
  local bin_path="$(command -v ${cmd%% *})"
  if [[ ! -f "$cache_file" || "$bin_path" -nt "$cache_file" ]]; then
    eval "$cmd" > "$cache_file"
  fi
  source "$cache_file"
}

_cache_eval fzf "fzf --zsh"                        # Fuzzy finder shell integration (Ctrl+R, Ctrl+T, Alt+C)
_cache_eval zoxide "zoxide init --cmd cd zsh"      # Smart cd that learns your most-used directories
_cache_eval uv "uv generate-shell-completion zsh"  # Shell completions for the uv package manager
_cache_eval starship "starship init zsh"           # Cross-shell prompt (must be last — takes over PS1)
