FRESH=0
if [[ ! -d ~/.zsh-snap ]]; then
  FRESH=1
  git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.zsh-snap
fi

export PATH=$HOME/.local/bin:$PATH

if [[ $FRESH -ne 0 ]]; then
  printf "Install ZSH plugins? [y/N]: "
  if read -q; then
    echo;
    mkdir -p ~/.local/bin/

    if ! which starship > /dev/null; then
      curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin \
       || (which cargo > /dev/null || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y) \
       && cargo install starship --locked
    fi
  fi
fi

# History Configuration (before sourcing oh-my-zsh)
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
setopt inc_append_history
setopt share_history

mkdir -p ~/.zsh-plugins
zstyle ':znap:*' repos-dir ~/.zsh-plugins
source ~/.zsh-snap/znap.zsh
export STARSHIP_CONFIG=~/.config/starship.toml
export STARSHIP_CACHE=~/.cache/starship
znap source ohmyzsh/ohmyzsh
znap source ohmyzsh/ohmyzsh plugins/{git,tmux,dotenv,heroku,vi-mode}
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

znap eval starship 'starship init zsh --print-full-init'
if which prompt_starship_precmd > /dev/null 2&> /dev/null; then
  prompt_starship_precmd
  znap prompt
else
  source <(starship init zsh --print-full-init)
fi

if which zoxide > /dev/null 2&> /dev/null; then
  eval "$(zoxide init zsh --cmd cd)"
fi

# Developer Variables
export PATH=$HOME/.nodejs/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

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
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true
tabs -2

# System Variables
export MANPATH="/usr/local/man:$MANPATH"
export MANPAGER='nvim +Man!'
export LANG=en_US.UTF-8
export EDITOR=nvim
export SYSTEMD_EDITOR="vim"
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Personal aliases
(( ${+aliases[tmux]} )) && unalias tmux
alias tmux="tmux -u"
which bat > /dev/null 2&> /dev/null && alias cat="bat"

if [[ $TERM == xterm ]]; then
  export TERM=xterm-256color
fi

dots() {

  # Check for znap installed correctly and update
  [ ! -d ~/.zsh-snap ] && \
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.zsh-snap

  # Update tmux plugins
  ~/.tmux/plugins/tpm/bin/install_plugins

  echo "Reload zsh to get all the goodies. You may need to manually install starship too."
}

# Other things worth sourcing
[ -f ~/.zsh-plugins/ohmyzsh/plugins/fzf/fzf.plugin.zsh ] && source ~/.zsh-plugins/ohmyzsh/plugins/fzf/fzf.plugin.zsh || true
[ -f ~/.env.zsh ] && source ~/.env.zsh || true
