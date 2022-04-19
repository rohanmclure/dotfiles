.PHONY: install install_zsh install_tmux install_vim clean

PREFIX?=$(HOME)
ZPLUG_HOME=$(PREFIX)/.zplug

install: zshrc vimrc tmux.conf starship.toml
	ln -sbf $(shell pwd)/zshrc $(PREFIX)/.zshrc
	ln -sbf $(shell pwd)/vimrc $(PREFIX)/.vimrc 
	mkdir -p $(PREFIX)/.config/nvim/ && \
		ln -sbf $(PREFIX)/.vimrc $(PREFIX)/.config/nvim/init.vim
	ln -sbf $(shell pwd)/tmux.conf $(PREFIX)/.tmux.conf 
	mkdir -p $(PREFIX)/.config/ && \
		ln -sbf $(shell pwd)/starship.toml $(PREFIX)/.config/

clean:
	rm -f $(PREFIX)/.zshrc
	rm -f $(PREFIX)/.vimrc
	rm -f $(PREFIX)/.tmux.conf
	rm -f $(PREFIX)/.tmux
