# ============================================================================
# Aliases — sourced from .zshrc
# ============================================================================

# ------------- Clipboard (X11)
# Pipe into it to copy, run it bare to paste: `pwd | c`, `c > file.txt`
alias c='xsel --clipboard'

# ------------- Listing (eza)
# --icons/--classify=auto only decorate output on a terminal, so these stay
# safe to pipe into grep, wc, etc.
alias l='eza -alh --classify=auto'          # All files incl. hidden, long, human sizes, type markers (/ * @)
alias la='eza -alh'                         # Long + human sizes
alias ll='eza -lh --icons=auto'             # Long + human sizes, with icons
alias lt='eza --sort=newest -l'             # Long, sorted by modification time (newest at the bottom)
alias lsdir='eza -lD --icons=auto'          # Directories only, long, with icons
alias lz='eza --sort=size -la'              # All files, sorted by size (largest at the bottom)
alias lftree='eza -l --tree'                # Recursive tree, long format (files and dirs)
alias ltree='eza -l --tree --icons=auto'    # Same as lftree, with icons
alias ldtree='eza -D --tree --icons=auto'   # Tree of directories only, with icons
alias lg='eza --long --grid'                # Long format laid out in columns
alias lZ='du -hd 1 . | sort -hr'            # Disk usage of each item in ., largest first

# ------------- Navigation
alias ..='cd ..'                            # Up one level
alias ...='cd ../..'                        # Up two levels
alias -- +='pushd .'                        # Bookmark the current dir on the dir stack
alias -- -='popd'                           # Jump back to the last bookmarked dir

# ------------- File and directory management
alias md='mkdir -p'                         # Create dir including missing parents
alias rd=rmdir                              # Remove an empty dir
alias rm='rm -I'                            # Prompt once before removing >3 files or recursing

# ------------- Networking
# ss (iproute2) replaces the deprecated net-tools netstat
alias ne='ss -tpe'                          # Active TCP connections with owning process and extended info
alias na='ss -ntalp'                        # All TCP sockets incl. listening, numeric ports, with process
alias ipp='dig +short myip.opendns.com @resolver1.opendns.com'  # Show your public IP address

# ------------- Processes
alias pf='ps -af --forest'                  # Terminal processes, full format, as a parent/child tree

# ------------- Editor and viewers
alias n='nvim'                              # Shortcut for Neovim
alias grep='grep --color=auto'              # Highlight matches ('always' leaks escape codes into pipes and files)
alias vw="fzf --preview 'bat --color \"always\" {}'"  # Fuzzy-pick a file with syntax-highlighted preview; prints its path

# ------------- Daily notes (see dn* functions in .zshrc)
# Single quotes defer $(date ...) to run time, so the file is always current.
alias todo='nvim "$DNHOME/TODO-$(date +%Y-%m).md"'  # Edit this month's TODO list
alias dne='nvim "$DNHOME/$(date +%F)"'              # Edit today's note

# ------------- Miscellaneous tools
alias xml2xsd='java -jar ~/repo/bin/trang.jar'  # Trang: infer an XSD from sample XML (xml2xsd in.xml out.xsd)
alias gcal='gcal --starting-day=1'              # Calendar with weeks starting on Monday
alias xmail='s-nail'                            # Command-line mail client

# ------------- Suffix aliases
# Typing just a file name opens it with the given program: `movie.mkv` -> `mpv movie.mkv`
alias -s {ape,avi,flv,m4a,mkv,mov,mp3,mp4,mpeg,mpg,ogg,ogm,wav,webm,vid}="mpv"  # Audio/video player
alias -s {toml,md,yaml,json,xml,xsl,xsd,html,log}="bat"                         # View with syntax highlighting
alias -s pdf="zathura"                                                          # PDF viewer
alias -s {epub,mobi,azw3}="ebook-viewer"                                        # Calibre e-book viewer
alias -s txt="$EDITOR"                                                          # Edit plain text ($EDITOR expanded at load time)

# ------------- zmv helpers (zmv is autoloaded in .zshrc; add -n for a dry run)
alias zcp='zmv -C'                          # Copy with patterns:  zcp '(*).log' '$1.bak'
alias zln='zmv -L'                          # Hard-link with patterns (add -s for symlinks)
