#git aliases
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

alias gdiff='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'

alias gco='git checkout'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you.

alias gunstage="git restore --staged ."
alias gstash="git stash -u"
