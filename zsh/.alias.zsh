alias c='xsel --clipboard'
alias l='eza -alhF'
alias la='eza -lh'
alias ll='eza -lh --icons'
alias lt='eza --sort=newest -l'
alias lsdir='eza -lD --icons'
alias lz='eza --sort=size -la'
alias lftree='eza -l --tree'
alias ltree='eza -l --tree --icons'
alias ldtree='eza -D --tree --icons'
alias lg='eza --long --grid'
alias lZ='du -hd 1 . | sort -hr'
alias ..='cd ..'
alias ...='cd ../..'
#
alias md='mkdir -p'
alias rd=rmdir
alias rm='rm -I'
alias -- +='pushd .'
alias -- -='popd'
#
alias ne='netstat -tpe'
alias na='netstat -ntalp'
#
alias xml2xsd='java -jar ~/repo/bin/trang.jar'
#
alias n='nvim'
alias grep='grep --color=always'
alias pf='ps -af --forest'
alias ipp='dig +short myip.opendns.com @resolver1.opendns.com'
alias vw="fzf --preview 'bat --color \"always\" {}'"
alias -s {ape,avi,flv,m4a,mkv,mov,mp3,mp4,mpeg,mpg,ogg,ogm,wav,webm,vid}=mpv
alias -s {md,txt,xml,xsl,xsd,html,log}=nvim
alias -s pdf=zathura
alias -s {epub,mobi,azw3}=ebook-viewer
alias todo='nvim $(echo ~/repo/doc/daily_notes/TODO-$(date +%Y-%m).md)'
alias dne='nvim $(echo ~/repo/doc/daily_notes/$(date +%Y-%m-%d))'
alias gcal='gcal --starting-day=1'
#
alias xmail='s-nail'
