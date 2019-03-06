changePHP() {
    if [ -z "$1" ]
    then
        php -v
    elif [ $1 = "list" ]
    then
	ls /etc/php
    else
        sudo update-alternatives --set php /usr/bin/php$1
    fi
}

alias phpver=changePHP

alias updatewip="git checkout wip && git pull origin master && git push --no-verify"

alias ll='ls -lA'

alias zshrc='${=EDITOR} ~/.zshrc'
