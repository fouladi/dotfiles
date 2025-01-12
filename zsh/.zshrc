# enable instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh # Load personal prompt config

# If you come from bash you might have to change your $PATH.
export PATH=".:$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
setopt auto_cd
cdpath=($HOME/dev ..)
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
export EDITOR='nvim'
# pyenv - pyenv initialization must happen before plugin loading of oh-my-zsh pyenv plugin.
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
plugins=(colored-man-pages zsh-autosuggestions fast-syntax-highlighting git virtualenv pyenv colorize extract zoxide)

source $ZSH/oh-my-zsh.sh
source ~/.alias.zsh

# User configuration
# Go & Rust
export GOPATH=$HOME/.go
export PATH=".:$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.go/bin:$PATH"
# git-fuzzy
export PATH="$HOME/.oh-my-zsh/git-fuzzy/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# In 'bash' if a glob doesn't match anything, you get back the unmodified
# glob you used. In 'zsh' this throws an error instead. to get the same
# behavour as 'bash':
setopt nonomatch
# sessions don't share the command history with each other although when
# you start new session it gets all the previous history from all
# sessions before it.
setopt append_history no_inc_append_history no_share_history

# dn - Daily notes command line tool
# ----------------------------------
export DNHOME=~/repo/doc/daily_notes
# 'dn' writes a bullet-pointed string to a file with today's date in YYYY-MM-DD format in the $DNHOME/ folder.
dn() {
  echo " * $1" >> $DNHOME/$(date "+%Y-%m-%d")
}
# 'dno' does the same, but the first argument is the filename. This can be
# used for future notes: dno 2030-10-01 "Mars Flight"
dno() {
  echo " * $2" >> $DNHOME/$1
}
# 'dnt' displays today's notes.
dnt() {
  echo $(date "+%Y-%m-%d")
  cat $DNHOME/$(date "+%Y-%m-%d")
}
# 'dnview' displays all files, or when an argument like 2019-10 is passed, ~/$DNHOME/2019-10*.
dnview() {
  find $DNHOME/$1* -type f -exec basename {} \; -exec cat {} \;
}
# 'dna' archive all files, or an argument like 2019-10 is passed in ~/$DNHOME/2019-10.md
dna() {
  find $DNHOME/$1* -type f -exec basename {} \; -exec cat {} \; > $DNHOME/archive/$1.md
  sed -i -e 's/^20/\n## 20/' $DNHOME/archive/$1.md
}
# 'dntodo' writes a TODO item to a file with this month date in TODO-YYYY-MM.md format in the $DNHOME/ folder
dntodo() {
  _FILENAME=$DNHOME/TODO-$(date "+%Y-%m").md
  if [[ ! -a $_FILENAME ]]; then
    echo "### $(date "+%Y-%m")" > $_FILENAME
  fi
  echo "- [ ] $1" >> $_FILENAME
}

# ========= fzf ====================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# ALT-C: uses tree command to show the entries of the directory
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
# fshow - git commit browser (using fzf)
gshow() {
  local out sha q
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" --print-query); do
    q=$(head -1 <<< "$out")
    while read sha; do
      git show --color=always $sha | less -R
    done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
  done
}

source $HOME/.config/broot/launcher/bash/br

# Node-Version-Manager
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Turn-Off CapsLock = VoidSymbol
setxkbmap -option caps:none
# Then use y instead of yazi to start, and press q to quit, you'll see
# the CWD changed. Sometimes, you don't want to change, press Q to quit.
function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
}
