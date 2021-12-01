# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export GOPATH=$HOME/go
export PATH=$HOME/bin:$HOME/.local/bin:usr/local/bin:$HOME/.cargo/bin:/usr/local/go/bin:$GOPATH/bin:$PATH

export XDG_CONFIG_HOME=$HOME/dotfiles
export EDITOR='nvim'
export COLORTERM=truecolor
LS_COLORS=$LS_COLORS:'di=0;35:ow=0;35'
export LS_COLORS

export FZF_DEFAULT_COMMAND='fd --follow -t f -H -E go/ -E node_modules/ -E .git -E .config'
# export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND='fd --follow -t d . $HOME'

export NVM_DIR="$HOME/.config/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

source $HOME/dotfiles/keybindings.zsh
source $HOME/.config/powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/doc/fzf/examples/key-bindings.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/dotfiles/.p10k.zsh ]] || source $HOME/dotfiles/.p10k.zsh
cd ~
