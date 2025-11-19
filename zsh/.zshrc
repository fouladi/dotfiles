setopt extended_glob    # advanced globbing
setopt null_glob        # empty expansion instead of literal pattern
setopt interactivecomments # comments in command-line

# ------------- Path configuration
path=(                  # 'path' as an "array"
  $path                 # keep existing PATH entries
  .
  /usr/local/bin
  $HOME/bin
  $HOME/.local/bin
  $HOME/.cargo/bin
  $HOME/.go/bin
)

# Remove duplicates and non-existent directories
typeset -U path
path=($^path(N-/))

# When you change 'path', 'PATH' is automatically adjusted - Zsh synchronizes them with each other.
export PATH             # PATH as an "environmen variable"

# ------------- Go environment
export GOPATH="$HOME/.go"

# ------------- Misc environment variables
export EDITOR='nvim'
export DNHOME="$HOME/repo/doc/daily_notes"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export LS_COLORS="$(vivid generate gruvbox-dark)"

# ------------- Zinit plugin manager setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# ------------- Plugins and themes ---
# Add in zsh plugins: Syntax highlighting, completions, autosuggestions, fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::virtualenv
zinit snippet OMZP::uv
zinit snippet OMZP::colorize
zinit snippet OMZP::extract
zinit snippet OMZP::zoxide
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# ------------- History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ------------- Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ------------- dn - Daily notes command line tool
export DNHOME=~/repo/doc/daily_notes
# 'dn' writes a bullet-pointed string to a file with today's date in YYYY-MM-DD format in the $DNHOME/ folder.
dn() {
  echo " * $1" >> $DNHOME/$(date "+%Y-%m-%d")
}
# 'dno' does the same, but the first argument is the filename. This can be
# used for future notes: dno 2030-10-01 "Mars Flight"
dno() {
  echo " * $2" >> $DNHOME/"$1"
}
# 'dnt' displays today's notes.
dnt() {
  echo $(date "+%Y-%m-%d")
  cat $DNHOME/$(date "+%Y-%m-%d")
}
# 'dnview' displays all files, or when an argument like 2019-10 is passed, ~/$DNHOME/2019-10*.
dnview() {
  find $DNHOME/"$1"* -type f -exec basename {} \; -exec cat {} \;
}
# 'dna' archive all files, or an argument like 2019-10 is passed in ~/$DNHOME/2019-10.md
dna() {
  find $DNHOME/"$1"* -type f -exec basename {} \; -exec cat {} \; > $DNHOME/archive/"$1".md
  sed -i -e 's/^20/\n## 20/' $DNHOME/archive/"$1".md
}
# 'dntodo' writes a TODO item to a file with this month date in TODO-YYYY-MM.md format in the $DNHOME/ folder
dntodo() {
  _FILENAME=$DNHOME/TODO-$(date "+%Y-%m").md
  if [[ ! -e $_FILENAME ]]; then
    echo "### $(date "+%Y-%m")" > "$_FILENAME"
  fi
  echo "- [ ] $1" >> "$_FILENAME"
}

# ------------ Misc / Keymap / Aliases ---
source ~/.alias.zsh

# Then use y instead of yazi to start, and press q to quit, you'll see
# the CWD changed. Sometimes, you don't want to change, press Q to quit.
y() {
  local tmp="$(mktemp -t 'yazi-cwd.XXXXXX')" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Select emacs keybinding for command
bindkey -e
# make ALT+BACKSPACE stop at non-alphanumeric characters (like Bash)
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
    zle -f kill
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

# fzf - Preview file content using 'bat'
export FZF_CTRL_T_OPTS=" --walker-skip .git,node_modules,target --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# fzf - Print tree structure in the preview window using 'tree'
export FZF_ALT_C_OPTS=" --walker-skip .git,node_modules,target --preview 'tree -C {}'"

# ------------ Auto activate/deactivate Python venv
python_venv() {
  MYVENV=./.venv
  # when you cd into a folder that contains $MYVENV
  [[ -d $MYVENV ]] && source $MYVENV/bin/activate > /dev/null 2>&1
  # when you cd into a folder that doesn't
  [[ ! -d $MYVENV ]] && deactivate > /dev/null 2>&1 || true
}
autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv
python_venv

# ------------- Tool initialization ---
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(uv generate-shell-completion zsh)"
eval "$(starship init zsh)"
