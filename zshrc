if [[ ! -d ~/.zplug ]]; then
  if ! git clone https://github.com/zplug/zplug ~/.zplug; then
    exit 1
  fi
fi

source ~/.zplug/init.zsh
zplug 'plugins/git', from:oh-my-zsh 
zplug 'plugins/tmux', from:oh-my-zsh 
zplug 'plugins/dotenv', from:oh-my-zsh 
zplug 'plugins/heroku', from:oh-my-zsh 
zplug 'zsh-users/zsh-completions', defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'spaceship-prompt/spaceship-prompt', as:theme

if ! zplug check --verbose; then
  printf "Install ZSH plugins? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

# Developer Variables
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.nodejs/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=/usr/local/bin:$PATH

# Also setup vim on launch if not already. Won't update.
if which nvim > /dev/null; then
  alias vim="nvim"
  if [[ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]]; then
    printf "Install Vim plugins? [y/N]: "
    if read -q; then
      echo
      curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      ln -sfb $HOME/.local/share/nvim/site/autoload/plug.vim ~/.config/nvim/init.vim
      nvim +PlugInstall +qall
    fi
  fi
fi

# Do the same for TMUX with tpm
if which tmux > /dev/null; then
  if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    printf "Install Tmux plugins? [y/N]: "
    if read -q; then
      echo
      git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
      export TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins/
      ~/.tmux/plugins/tpm/bin/install_plugins
    fi
  fi
fi

# oh-my-zsh configuration
export CASE_SENSITIVE="false"
export HYPHEN_INSENSITIVE="true"
export ENABLE_CORRECTION="true"
tabs -2
export SPACESHIP_BATTERY_SHOW="false"

# Bindkeys
bindkey "^U"    backward-kill-line
bindkey "^u"    backward-kill-line
bindkey "^[l"   down-case-word
bindkey "^[L"   down-case-word
bindkey "^[f" forward-word
bindkey "^[b" backward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# System Variables
setopt NULL_GLOB
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR=nvim
export SYSTEMD_EDITOR="vim"
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Personal aliases
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -la'
alias pd="popd"
alias vim="nvim"
alias bim="vim"

if [[ $TERM == xterm ]]; then
  export TERM=xterm-256color
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.env.zsh ] && source ~/.env.zsh
