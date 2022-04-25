FROM ubuntu:latest

RUN apt update
RUN apt install -y build-essential bash zsh libncurses-dev perl neovim tmux make wget git curl fzf
RUN useradd user \
 && mkdir -p /home/user \
 && chown -R user /home/user \
 && chmod 755 /home/user
USER user
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
 && /home/user/.cargo/bin/cargo install starship --locked
COPY . /home/user/dotfiles
WORKDIR /home/user/dotfiles

RUN make PREFIX=/home/user/ install

CMD zsh
