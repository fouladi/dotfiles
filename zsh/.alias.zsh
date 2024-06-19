alias c='xsel --clipboard'
alias l='exa -alFh'
alias la='exa -lh'
alias ll='exa -lh --icons'
alias lt='exa --sort=newest -l'
alias lsdir='exa -lD --icons'
alias lz='exa --sort=size -la'
alias lftree='exa -l --tree'
alias ltree='exa -l --tree --icons'
alias ldtree='exa -D --tree --icons'
alias lg='exa --long --grid'
alias lZ='du -hd 1 . | sort -hr'
#
alias md='mkdir -p'
alias rd=rmdir
alias rm='rm -f'
alias -- +='pushd .'
alias -- -='popd'
#
alias n='netstat -tpe'
alias na='netstat -ntalp'
#
alias xml2xsd='java -jar ~/repo/bin/trang.jar'
#
alias nv='nvim'
alias grep='grep --color=always'
alias pf='ps -af --forest'
alias ipp='dig +short myip.opendns.com @resolver1.opendns.com'
alias vw="fzf --preview 'bat --color \"always\" {}'"
alias -s {ape,avi,flv,m4a,mkv,mov,mp3,mp4,mpeg,mpg,ogg,ogm,wav,webm,vid}=mpv
alias -s {md,txt,xml,xsl,xsd,html,log}=nv
alias -s pdf=zathura
alias -s {epub,mobi,azw3}=ebook-viewer
alias todo='nvim $(echo ~/repo/doc/daily_notes/TODO-$(date +%Y-%m).md)'
alias dne='nvim $(echo ~/repo/doc/daily_notes/$(date +%Y-%m-%d))'
alias gcal='gcal --starting-day=1'
#
alias xmail='s-nail'
