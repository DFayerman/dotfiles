# aliases

# general
alias mkdir="mkdir -pv";
alias c="clear";
alias wget="wget -c";
alias whatisthis="cat /etc/os-release"
alias l="ls -sh1FAur --group-directories-first --color=auto"
alias excel="/mnt/c/Program\ Files/Microsoft\ Office/root/Office16/EXCEL.EXE"
alias whatsmyip="curl -s ip4only.me/api/ | grep -Eo '([0-9]{2,3}\.){3}[0-9]{1,3}'"
# navigation
alias ..="cd .."
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
alias gs='git status'
# tmux
alias tmux="tmux -f ~/dotfiles/tmux.conf"
alias tm="tmux a || tmux new-session -s $1"
alias td='tmux detach'
alias tmls='tmux list-sessions'

## Neovim aliases for sanity
if [[ -f '/usr/local/bin/nvim' ]]; then
	alias vnvim="nvim"
	alias n="nvim"
	alias vim="nvim"
	alias bnvim="nvim"
	alias nv="nvim"
	alias nvi="nvim"
	alias vi="nvim"
else
	alias nvim="$HOME/nvim.appimage"
	alias n="$HOME/nvim.appimage"
	alias nv="$HOME/nvim.appimage"
	alias vi="$HOME/nvim.appimage"
	alias vnvim="$HOME/nvim.appimage"
	alias nivm="$HOME/nvim.appimage"
	alias bnvim="$HOME/nvim.appimage"
fi

## functions

...() {
	repeat 2 { cd .. }
}

update() {
	sudo apt update
	sudo apt -y upgrade
	sudo apt autoremove --purge
	echo -n ".\n.\n.\n.\nUpdate NPM global packages (y/n)?"
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then 
			npm -g update
	else
			echo "go nuts.."
	fi
}

update_nvim_nightly() {
	sudo rm ~/nvim.appimage
	if [[ $(ping -qc 1 github.com) != 0 ]]
	then
		wget -O $HOME/nvim.appimage https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage	
		chmod u+x $HOME/nvim.appimage
		echo "neovim nightly updated"
	else
		echo "github.com could not be reached or download link no longer valid"
	fi
}

update_go_latest() {
	if [[ $(ping -qc 1 go.dev | echo $?) != 0 ]]
	then
		echo "Golang website not responding, ending upgrade attempt..."
		return
	fi
	cd /
	GOVER="$(curl -s https://go.dev/dl/|grep -Eom1 '/dl.*gz')"
	echo "https://go.dev/${GOVER}"|{ read url; sudo wget $url; }
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

print_all_the_colors() {
    for code in {000..255}; do print -P -- "$code: %F{$code}Test%f"; done
}

get_current_pyenv() {
	pyenv version | grep -Eo "([[:digit:]]{1,2}\.){2}[[:digit:]]{1,2}"
}

## keybindings

bindkey -s '^f' 'fzf_find_and_open\n'


