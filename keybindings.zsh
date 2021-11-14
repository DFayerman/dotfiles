alias mkdir="mkdir -pv";
alias c="clear";
alias wget="wget -c";
alias update="sudo apt update && sudo -S apt -y upgrade"
alias l="ls -sh1FAur --group-directories-first --color=auto"
alias ~="cd ~"
alias cdc="cd /mnt/c/Users/david/OneDrive/code"
alias tmux="tmux -f ~/dotfiles/tmux.conf"

updateGoLatest() {
	cd /
	GOVER="$(curl -s https://golang.org/dl/|grep -Eom1 '/dl.*gz')"
	echo "https://golang.org${GOVER}"|{ read url; sudo wget $url; }
	sudo rm -rf /usr/local/go && echo "$GOVER"|grep -Eo 'go.*gz'|sudo tar -C /usr/local -xzf -
	echo "updated to $(go version)"
}

