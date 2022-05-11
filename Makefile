.PHONY: install install_zsh install_tmux install_vim clean

PREFIX?=$(HOME)
ZPLUG_HOME=$(PREFIX)/.zplug

LN := ln
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	LN += -sbf
endif
ifeq ($(UNAME_S),Darwin)
	LN += -sf
endif

install: zshrc vimrc tmux.conf starship.toml
	${LN} $(shell pwd)/zshrc $(PREFIX)/.zshrc
	${LN} $(shell pwd)/vimrc $(PREFIX)/.vimrc 
	mkdir -p $(PREFIX)/.config/nvim/ && \
		${LN} $(PREFIX)/.vimrc $(PREFIX)/.config/nvim/init.vim
	${LN} $(shell pwd)/tmux.conf $(PREFIX)/.tmux.conf 
	mkdir -p $(PREFIX)/.config/ && \
		${LN} $(shell pwd)/starship.toml $(PREFIX)/.config/

clean:
	rm -f $(PREFIX)/.zshrc
	rm -f $(PREFIX)/.vimrc
	rm -f $(PREFIX)/.tmux.conf
	rm -f $(PREFIX)/.tmux
