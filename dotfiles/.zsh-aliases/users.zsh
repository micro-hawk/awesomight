
alias ht='htop'
alias nf='neofetch'

#Window manager Things => awesomeWM
alias bb='sudo ~/.config/awesome/brightness.sh'
alias screenlayout='sh ~/.screenlayout/samsungMonitor.sh'

alias plz="sudo"
alias dirsize='du -sch ./*'
alias getpath="find -type f | fzf | sed 's/^..//' | tr -d '\n' | xclip -selection c"
alias weather='curl wttr.in'


# mvn aliases
alias mco="mvn clean compile"
alias mci="mvn clean install"
alias mrun="mvn spring-boot:run"

# extraAliases
fcd(){
  cd "$(find -type d | fzf)"
}
