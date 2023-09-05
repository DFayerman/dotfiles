export SHELL=/bin/zsh

export COLORTERM=truecolor
export LS_COLORS=$LS_COLORS:'di=1;35:ow=0;35:ex=1;94:ln=1;33:'

if [[ $s(command -v fd) ]]; then
	export FZF_CTRL_T_COMMAND='fd --follow -t f -H --exclude .git .'
	export FZF_ALT_C_COMMAND='fd --follow -E go/ -E node_modules/ -E .git -t d . $HOME'
fi

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

export NVM_COLORS='yMeWg'

# ZSH completion?
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
#complete -C '/usr/bin/aws_completer' aws

source $HOME/dotfiles/keybindings.zsh

if [ -f "/etc/arch-release" ]; then
	source /usr/share/fzf/key-bindings.zsh
else
	#source /usr/share/doc/fzf/examples/key-bindings.zsh
	[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

if [ -d $HOME/.pyenv ]; then
	export PYENV_ROOT=$HOME/.pyenv
	export PATH=$PYENV_ROOT/bin:$PATH
	export PATH=.local/bin:$PATH
	eval "$(pyenv init -)"
fi

if [[ $s(command starship help) ]]; then
	export STARSHIP_CONFIG=$HOME/dotfiles/starship.toml
	eval "$(starship init zsh)"
fi

# safe at home :)
cd ~
