# Runs for every interactive terminal

# --- Instant prompt (Powerlevel10k) ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Zinit plugin manager setup ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# --- Plugins and themes ---
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Syntax highlighting, completions, autosuggestions, fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Oh My Zsh snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::virtualenv
zinit snippet OMZP::pyenv
zinit snippet OMZP::colorize
zinit snippet OMZP::extract
zinit snippet OMZP::zoxide
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# --- Prompt (Powerlevel10k) ---
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --- History ---
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups
setopt hist_save_no_dups hist_ignore_dups hist_find_no_dups

# --- Completion styling ---
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# --- Daily Notes Commands ---
dn() { echo " * $1" >> "$DNHOME/$(date '+%Y-%m-%d')"; }
dno() { echo " * $2" >> "$DNHOME/$1"; }
dnt() { echo "$(date '+%Y-%m-%d')"; cat "$DNHOME/$(date '+%Y-%m-%d')"; }
dnview() { find "$DNHOME/$1"* -type f -exec basename {} \; -exec cat {} \; }
dna() {
  find "$DNHOME/$1"* -type f -exec basename {} \; -exec cat {} \; > "$DNHOME/archive/$1.md"
  sed -i -e 's/^20/\n## 20/' "$DNHOME/archive/$1.md"
}
dntodo() {
  local _FILENAME="$DNHOME/TODO-$(date '+%Y-%m').md"
  [[ ! -a $_FILENAME ]] && echo "### $(date '+%Y-%m')" > "$_FILENAME"
  echo "- [ ] $1" >> "$_FILENAME"
}

# --- Misc / Keymap / Aliases ---
source ~/.alias.zsh
# Turn-Off CapsLock = VoidSymbol
setxkbmap -option caps:none

# --- y() wrapper for yazi file manager ---
y() {
  local tmp="$(mktemp -t 'yazi-cwd.XXXXXX')" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# --- Tool initialization ---
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
