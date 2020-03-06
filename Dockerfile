FROM alpine:latest

COPY . /dotfiles
WORKDIR /dotfiles

RUN apk add zsh neovim tmux make wget git
RUN make install

CMD zsh
