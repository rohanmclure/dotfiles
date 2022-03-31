FRESH=0
if [[ ! -d ~/.zplug ]]; then
  FRESH=1
  if ! git clone https://github.com/zplug/zplug ~/.zplug; then
    exit 1
  fi
fi

source ~/.zplug/init.zsh
zplug "ohmyzsh/ohmyzsh", use:"lib/*.zsh"
zplug 'plugins/git', from:oh-my-zsh 
zplug 'plugins/tmux', from:oh-my-zsh 
zplug 'plugins/dotenv', from:oh-my-zsh 
zplug 'plugins/heroku', from:oh-my-zsh 
zplug 'zsh-users/zsh-completions', defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug 'spaceship-prompt/spaceship-prompt', as:theme
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

if [[ $FRESH -ne 0 ]]; then
  printf "Install ZSH plugins? [y/N]: "
  if read -q; then
    echo;
    zplug install
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
  if [[ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]]; then
    printf "Install Vim plugins? [y/N]: "
    if read -q; then
      echo
      curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      mkdir -p ~/.local/share/nvim/site/autoload/
      ln -sfb $HOME/.vim/autoload/plug.vim ~/.local/share/nvim/site/autoload/plug.vim
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
export CASE_SENSITIVE=false
export HYPHEN_INSENSITIVE=true
export ENABLE_CORRECTION=true
tabs -2
export SPACESHIP_BATTERY_SHOW=false
export SPACESHIP_PROMPT_PREFIXES_SHOW=true

# System Variables
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR=nvim
export SYSTEMD_EDITOR="vim"
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Personal aliases
alias less='less -R'
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -la'
alias pd="popd"
alias vim="nvim"
alias bim="vim"
unalias tmux
alias tmux="tmux -u"

if [[ $TERM == xterm ]]; then
  export TERM=xterm-256color
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh || true
[ -f ~/.env.zsh ] && source ~/.env.zsh || true
