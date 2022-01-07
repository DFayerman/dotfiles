# ZSH run commands


if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PYENV_ROOT="$HOME/.pyenv"
export GOPATH=$HOME/go
export PATH=$HOME/bin:$HOME/.local/bin:$PYENV_ROOT/bin:$HOME/.cargo/bin:usr/local/bin:$HOME/.cargo/bin:/usr/local/go/bin:$GOPATH/bin:$PATH

export XDG_CONFIG_HOME=$HOME/dotfiles
export EDITOR='nvim'
export COLORTERM=truecolor
export LS_COLORS=$LS_COLORS:'di=0;35:ow=0;35'

export FZF_DEFAULT_COMMAND='fd --follow -t f -H -E go/ -E node_modules/ -E .git -E .config'
# export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND='fd --follow -t d . $HOME'

export NVM_DIR="$HOME/.config/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

source $HOME/.config/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f $HOME/.config/.p10k.zsh ]] || source $HOME/.config/.p10k.zsh

source $HOME/dotfiles/keybindings.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh

eval "$(pyenv init -)"
cd ~
