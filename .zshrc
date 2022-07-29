# ZSH run commands


if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export SHELL=/bin/zsh
export PYENV_ROOT=$HOME/.pyenv
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

if hash yarn 2>/dev/null; then
	export PATH="$PATH:$(yarn global bin)"
fi

if [ -d /usr/local/go/bin/ ]; then
  export GOPATH=~/go
  export GOBIN="$GOPATH/bin"
  export PATH="/usr/local/go/bin:$GOBIN:$PATH"
elif [ -d ~/.go/bin/ ]; then
  export GOPATH="$HOME/.gopath"
  export GOROOT="$HOME/.go"
  export GOBIN="$GOPATH/bin"
  export PATH="$GOPATH/bin:$PATH"
fi

if [ -d $HOME/.pyenv ]; then
	export PYENV_ROOT=$HOME/.pyenv
	export PATH=$PYENV_ROOT/bin:$PATH
fi

if [ -d $HOME/.cargo ]; then
	export PATH=$HOME/.cargo/bin:$PATH
fi

# export EDITOR='nvim'
export COLORTERM=truecolor
export LS_COLORS=$LS_COLORS:'di=1;35:ow=0;35:ex=1;94:ln=1;33:'
export AWS_PROFILE=default

if [[ $s(command -v fd) ]]; then
	export FZF_CTRL_T_COMMAND='fd --follow -t f -H --exclude .git .'
	export FZF_ALT_C_COMMAND='fd --follow -E go/ -E node_modules/ -E .git -t d . $HOME'
	# export FZF_ALT_C_COMMAND='fd --follow -E go/ -E node_modules/ -E .git -E agilitek -t d . $HOME'
fi

export NVM_DIR="$HOME/.config/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# export NVM_COLORS='yMeWg'

source $HOME/.config/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f $XDG_CONFIG_HOME/.p10k.zsh ]] || source $XDG_CONFIG_HOME/.p10k.zsh

# ZSH completion?
# autoload -Uz compinit
# compinit
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/bin/aws_completer' aws

source $HOME/dotfiles/keybindings.zsh

if [ -f "/etc/arch-release" ]; then
	source /usr/share/fzf/key-bindings.zsh
else
	source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

eval "$(pyenv init -)"

# safe at home :)
cd ~
