FROM alpine:latest

RUN apk add bash zsh zsh-vcs ncurses perl neovim tmux make wget git curl fzf shadow
RUN adduser -D user
RUN chown -R user /home/user
RUN chmod 755 /home/user
USER user
COPY . /home/user/dotfiles
WORKDIR /home/user/dotfiles

RUN make PREFIX=/home/user/ install

CMD zsh
