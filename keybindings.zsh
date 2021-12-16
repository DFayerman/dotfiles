# aliases

alias mkdir="mkdir -pv";
alias c="clear";
alias wget="wget -c";
alias update="sudo apt update && sudo -S apt -y upgrade"
alias l="ls -sh1FAur --group-directories-first --color=auto"
alias ~="cd ~"
alias cdc="cd ~/code"
alias cdo="cd /mnt/c/Users/david/OneDrive/content"
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


# functions

updateGoLatest() {
	cd /
	GOVER="$(curl -s https://golang.org/dl/|grep -Eom1 '/dl.*gz')"
	echo "https://golang.org${GOVER}"|{ read url; sudo wget $url; }
	sudo rm -rf /usr/local/go 
	sudo tar -C /usr/local -xzf go*.gz
	sudo rm go*.gz
	echo "updated to $(go version)"
}

fzf_find_and_open() {
	file="$(fzf)"
	cd $HOME/${file%/*}
	nvim ${file//*\/}
}

# keybindings

bindkey -s '^f' 'fzf_find_and_open\n'


