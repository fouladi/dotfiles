# ------------- Shell options
setopt extended_glob           # Advanced globbing (e.g., ^, ~, # qualifiers)
setopt interactivecomments     # Allow comments (#) in interactive shell
# Note: null_glob is intentionally NOT set globally. It makes unmatched globs
# expand to nothing, so `ls *.foo` lists the whole directory and `rm *.bak`
# runs with no args. Use the (N) qualifier per-glob instead, e.g. *.foo(N).

# ------------- Path configuration
# Zsh keeps 'path' (array) and 'PATH' (scalar) in sync automatically.
# typeset -U keeps the first occurrence of each entry, so user directories
# listed here take precedence over system ones.
typeset -U path
path=(
  $HOME/.cargo/bin             # Rust toolchain binaries
  $HOME/.local/bin
  $HOME/bin
  $HOME/.go/bin                # Go compiled binaries
  $path                        # Preserve existing PATH entries
  /usr/local/bin
)
# Drop '.' and empty entries (both mean "current directory", which lets any
# directory you cd into shadow system commands), then prune non-existent dirs.
path=(${path:#(.|)})
path=($^path(N-/))
export PATH

# ------------- Go environment
export GOPATH="$HOME/.go"

# ------------- Environment variables
export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'
export DNHOME="$HOME/repo/doc/daily_notes"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# ------------- Cached tool initialization
# Instead of running `eval "$(tool init zsh)"` on every shell start (which
# forks a subprocess each time), we cache the output to a file and source it.
# The cache is regenerated when the tool binary or this .zshrc changes (the
# latter covers edits to the init arguments below).
_zsh_cache_dir="$XDG_CACHE_HOME/zsh"
[[ -d "$_zsh_cache_dir" ]] || mkdir -p "$_zsh_cache_dir"

_cache_eval() {
  local name="$1" cmd="$2"
  local cache_file="$_zsh_cache_dir/$name.zsh"
  # $commands[] resolves the real binary even if an alias of the same name
  # exists (e.g. OMZP::uv aliases uv='noglob uv').
  local bin_path="${commands[${cmd%% *}]}"
  [[ -n "$bin_path" ]] || return 1   # Tool not installed: skip silently
  if [[ ! -s "$cache_file" || "$bin_path" -nt "$cache_file" || "$ZDOTDIR/.zshrc" -nt "$cache_file" ]]; then
    # Write to a temp file first so a failed command never leaves an empty cache
    eval "$cmd" >| "$cache_file.tmp" && mv -f "$cache_file.tmp" "$cache_file"
  fi
  [[ -s "$cache_file" ]] && source "$cache_file"
}

# LS_COLORS from vivid (cached; must be set before the list-colors zstyle)
_cache_eval vivid "vivid generate gruvbox-dark | sed \"s/.*/export LS_COLORS='&'/\""

# Zinit Plugin Manager
#
# Zinit is a flexible and fast Zsh plugin manager. It supports turbo mode
# (deferred loading) to keep shell startup snappy.
# Repository: https://github.com/zdharma-continuum/zinit
ZINIT_HOME="$XDG_DATA_HOME/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "${ZINIT_HOME:h}"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
#
# Plugins use "turbo mode" (wait lucid) where possible, meaning they load
# asynchronously after the first prompt is drawn — faster perceived startup.
# Turbo plugins load in the order declared, and the order matters:
#   fzf-tab -> autosuggestions -> syntax-highlighting -> history-substring-search

# --- zsh-completions ---
# Adds ~300 additional completion definitions for common tools (docker, cargo,
# fd, rg, etc.) not included in Zsh by default.
# 'blockf' prevents the plugin from modifying fpath at source time — zinit
# manages its completions instead, before compinit runs.
zinit ice blockf
zinit light zsh-users/zsh-completions

# --- fzf-tab ---
# Replaces the default completion menu with fzf (fuzzy finder). Allows fuzzy
# matching, preview panes, and multi-select in tab completion.
# Must load after compinit but before plugins that wrap widgets
# (autosuggestions, syntax-highlighting).
zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# --- zsh-autosuggestions ---
# Shows a dimmed suggestion of the most recent matching history entry as you
# type. Accept with → (right arrow) or End key.
zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# --- zsh-syntax-highlighting ---
# Highlights commands as you type: valid commands in green, errors in red,
# strings, options, and paths each get distinct colors.
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

# --- zsh-history-substring-search ---
# Adds Up/Down arrow history search by substring. Type a partial command, then
# press Up to cycle through matching history entries. Without typed text, it
# behaves like normal history navigation.
# Must load after zsh-syntax-highlighting (per its README).
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
# (OMZP::virtualenv was dropped: it only provides a prompt helper, and
# starship already shows the active venv. OMZP::zoxide was dropped: it ran a
# second, uncached `zoxide init` and defined z/zi on top of our `cd` setup.)

zinit snippet OMZL::git.zsh            # Git library (core git functions used by OMZP::git)
zinit snippet OMZP::git                # Git aliases (gst, gco, gp, gl, etc.)
zinit snippet OMZP::sudo               # Press ESC twice to prepend 'sudo' to current/last command
zinit snippet OMZP::uv                 # uv aliases (uva, uvr, uvs, ...) and completions
zinit snippet OMZP::colorize           # Syntax-highlight file contents via 'ccat' / 'cless'
zinit snippet OMZP::extract            # Universal 'extract' command for any archive type
zinit snippet OMZP::command-not-found  # Suggests package to install when command is missing

# ------------- Load completions
# compinit initializes the completion system. Must run after plugins that add
# completion definitions (like zsh-completions) have populated fpath.
# The dump file lives in the cache dir so it stays out of the dotfiles repo.
autoload -Uz compinit && compinit -d "$_zsh_cache_dir/zcompdump"

# Replay completions that zinit captured during plugin loading
zinit cdreplay -q

# ------------- Enable zmv: renaming multiple files using pattern
# zmv '(*).log' '$1.txt'           # Rename .log to .txt
# zmv -w '*.log' '*.txt'           # Same thing, simpler syntax
# zmv -n '(*).log' '$1.txt'        # Dry run (preview changes)
# zmv -i '(*).log' '$1.txt'        # Interactive mode (confirm each)
autoload -Uz zmv

# History
#
HISTSIZE=50000                   # Max entries kept in memory
HISTFILE="$ZDOTDIR/.zsh_history" # Persistent history file (git-ignored)
SAVEHIST=$HISTSIZE               # Max entries saved to HISTFILE
setopt share_history             # Share history across sessions (implies incremental append)
setopt hist_ignore_space         # Commands starting with space are not recorded
setopt hist_ignore_all_dups      # Remove ALL older duplicates of a new entry
setopt hist_save_no_dups         # Don't write duplicates to HISTFILE
setopt hist_find_no_dups         # Skip duplicates when searching history (Ctrl+R)
setopt hist_reduce_blanks        # Trim superfluous whitespace before saving

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
# All functions accept unquoted multi-word text: `dn bought milk`.

# 'dn' — append a bullet point to today's note file
dn() {
  print -r -- " * $*" >> "$DNHOME/$(date +%F)"
}

# 'dno' — append a bullet to a specific date file (e.g., dno 2030-10-01 Mars Flight)
dno() {
  local day="$1"; shift
  print -r -- " * $*" >> "$DNHOME/$day"
}

# 'dnt' — display today's notes
dnt() {
  local file="$DNHOME/$(date +%F)"
  print -r -- "${file:t}"
  [[ -f "$file" ]] && cat -- "$file"
}

# 'dnview' — display notes for a date prefix (e.g., dnview 2024-03), in date order
dnview() {
  local file
  for file in "$DNHOME/$1"*(N.); do
    print -r -- "${file:t}"
    cat -- "$file"
  done
}

# 'dna' — archive notes for a date prefix into a single markdown file
dna() {
  local -a files=("$DNHOME/$1"*(N.))
  if (( ! $#files )); then
    print -u2 "dna: no notes match '$1'"
    return 1
  fi
  mkdir -p "$DNHOME/archive"
  local file
  for file in $files; do
    print -r -- $'\n'"## ${file:t}"
    cat -- "$file"
  done >| "$DNHOME/archive/$1.md"
}

# 'dntodo' — add a TODO item to this month's TODO file
dntodo() {
  local file="$DNHOME/TODO-$(date +%Y-%m).md"
  [[ -e "$file" ]] || print -r -- "### $(date +%Y-%m)" > "$file"
  print -r -- "- [ ] $*" >> "$file"
}

# ============================================================================
# Aliases and helper functions
# ============================================================================
source "$ZDOTDIR/.alias.zsh"

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

# ============================================================================
# Keybindings
# ============================================================================
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
export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Alt+C: directory picker with tree preview
export FZF_ALT_C_OPTS="--walker-skip .git,node_modules,target --preview 'tree -C {}'"

# ============================================================================
# Python Virtual Environment Auto-Activation
# ============================================================================
# Activates the nearest .venv found in the current directory or any parent,
# so it stays active in project subdirectories. On leaving the project it
# deactivates — but only venvs it activated itself, so a venv you activated
# manually is left alone.
_auto_venv() {
  local dir="$PWD" venv=""
  while [[ -n "$dir" ]]; do
    if [[ -f "$dir/.venv/bin/activate" ]]; then
      venv="$dir/.venv"
      break
    fi
    dir="${dir%/*}"
  done

  if [[ -n "$venv" ]]; then
    if [[ "$VIRTUAL_ENV" != "$venv" ]]; then
      source "$venv/bin/activate" > /dev/null 2>&1 && typeset -g _AUTO_VENV="$VIRTUAL_ENV"
    fi
  elif [[ -n "$VIRTUAL_ENV" && "$VIRTUAL_ENV" == "$_AUTO_VENV" ]]; then
    deactivate > /dev/null 2>&1
    unset _AUTO_VENV
  fi
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _auto_venv
_auto_venv  # Run once at shell start for current directory

# ============================================================================
# Tool Initialization (cached, see _cache_eval above)
# ============================================================================
_cache_eval fzf "fzf --zsh"                        # Fuzzy finder shell integration (Ctrl+R, Ctrl+T, Alt+C)
_cache_eval zoxide "zoxide init --cmd cd zsh"      # Smart cd that learns your most-used directories
_cache_eval uv "uv generate-shell-completion zsh"  # Shell completions for the uv package manager
_cache_eval starship "starship init zsh"           # Cross-shell prompt (must be last — takes over PS1)
