FRESH=0
if [[ ! -d ~/.zsh-snap ]]; then
  FRESH=1
  git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.zsh-snap
fi

# autoload -Uz compinit
# compinit

if [[ $FRESH -ne 0 ]]; then
  printf "Install ZSH plugins? [y/N]: "
  if read -q; then
    echo;
    mkdir -p ~/.local/bin/
    curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin
  fi
fi

source ~/.zsh-snap/znap.zsh
export STARSHIP_CONFIG=~/.config/starship.toml
export STARSHIP_CACHE=~/.cache/starship
znap source ohmyzsh/ohmyzsh lib plugins/{git,tmux,dotenv,heroku,vi-mode}
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap eval starship 'starship init zsh --print-full-init'
znap prompt

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
export HISTFILE=$HOME/.zsh_history
export CASE_SENSITIVE=false
export HYPHEN_INSENSITIVE=true
export ENABLE_CORRECTION=true
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true
tabs -2

setopt inc_append_history
setopt share_history

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
(( ${+aliases[tmux]} )) && unalias tmux
alias tmux="tmux -u"

if [[ $TERM == xterm ]]; then
  export TERM=xterm-256color
fi

dots() {

  # Update zsh plugins + manager
  antibody update
  antibody bundle < ~/.config/antibody_bundles.txt > ~/.plugins.zsh
  source ~/.plugins.zsh

  # Update vim plugins
  nvim +PlugInstall +qall

  # Update tmux plugins
  ~/.tmux/plugins/tpm/bin/install_plugins

}

# Other things worth sourcing
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh || true
[ -f ~/.env.zsh ] && source ~/.env.zsh || true
