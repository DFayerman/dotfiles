# aliases

# general
alias mkdir="mkdir -pv";
alias c="clear";
alias wget="wget -c";
alias whatisthis="cat /etc/os-release"
alias l="ls -sh1FAur --group-directories-first --color=auto"
alias excel="/mnt/c/Program\ Files/Microsoft\ Office/root/Office16/EXCEL.EXE"
# navigation
alias ..="cd .."
alias ...="cd .. & cd .."
alias ~="cd ~"
alias cdc="cd ~/code"
alias cdo="cd /mnt/c/Users/david/OneDrive/content"
# Python
alias py="python"
alias venv="virtualenv .venv"
alias pyact='source .venv/bin/activate'
alias activate='source .venv/bin/activate'
# Git
alias ga="git add -A"
alias gcm="git commit -m"
# tmux
alias tmux="tmux -f ~/dotfiles/tmux.conf"

## Neovim aliases for sanity

## for use with appimage version of Neovim
# alias nvim="$HOME/nvim.appimage"
# alias nv="$HOME/nvim.appimage"
# alias vi="$HOME/nvim.appimage"
# alias vnvim="$HOME/nvim.appimage"
# alias nivm="$HOME/nvim.appimage"
# alias bnvim="$HOME/nvim.appimage"

alias vnvim="nvim"
alias vim="nvim"
alias bnvim="nvim"
alias nv="nvim"
alias nvi="nvim"

## functions

update() {
	sudo apt update
	sudo apt -y upgrade
	echo -n ".\n.\n.\n.\nUpdate NPM global packages (y/n)?"
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then 
			npm -g update
	else
			echo "go nuts.."
	fi
}

# MAY NO LONGER WORK
updateGoLatest() {
	cd /
	GOVER="$(curl -s https://golang.org/dl/|grep -Eom1 '/dl.*gz')"
	echo $GOVER
	echo "https://golang.org${GOVER}"|{ read url; sudo wget $url; }
	sudo rm -rf /usr/local/go 
	sudo tar -C /usr/local -xzf go*.gz
	sudo rm go*.gz
	echo "updated to $(go version)"
}

# for fuzzy finder keybind
fzf_find_and_open() {
	file="$(fzf)"
	cd $HOME/${file%/*}
	nvim ${file//*\/}
}

## keybindings

bindkey -s '^f' 'fzf_find_and_open\n'


