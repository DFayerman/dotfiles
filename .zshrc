# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:$HOME/.local/bin:usr/local/bin:/usr/local/go/bin:$PATH
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
export FZF_ALT_C_COMMAND='rg --hidden -l ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export NVM_DIR="$HOME/.config/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
source ~/.config/keybindings/keybindings.zsh
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/doc/fzf/examples/key-bindings.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/p10k/.p10k.zsh ]] || source ~/.config/p10k/.p10k.zsh
cd ~
