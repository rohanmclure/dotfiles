.PHONY: all install fix_init_vim clean

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

all:

install: $(PREFIX)/.zshrc $(PREFIX)/.vimrc $(PREFIX)/.tmux.conf \
		 $(PREFIX)/.config/starship.toml $(PREFIX)/.config/bat/config \
		 $(PREFIX)/.gitconfig

$(PREFIX)/.zshrc: zshrc
	${LN} $(shell pwd)/$< $@

$(PREFIX)/.vimrc: vimrc fix_init_vim $(PREFIX)/.config/starship.toml
	${LN} $(shell pwd)/$< $@

fix_init_vim:
	# Overwrite init.vim to be a symlink
	mkdir -p $(PREFIX)/.config/nvim/ && \
		([ ! -f $(PREFIX)/.config/nvim/init.vim ] || cp $(PREFIX)/.config/nvim/init.vim $(PREFIX)/.config/nvim/init.vim.backup) && \
		${LN} $(PREFIX)/.vimrc $(PREFIX)/.config/nvim/init.vim

$(PREFIX)/.config/bat/config: batrc
	mkdir -p $(PREFIX)/.config/bat/ && \
		${LN} $(shell pwd)/$< $@

$(PREFIX)/.config/starship.toml: starship.toml
	mkdir -p $(PREFIX)/.config/ && \
		${LN} $(shell pwd)/$< $@

$(PREFIX)/.gitconfig: gitconfig
	${LN} $(shell pwd)/$< $@

$(PREFIX)/.tmux.conf: tmux.conf
	${LN} $(shell pwd)/$< $@

clean:
	rm -f $(PREFIX)/.zshrc
	rm -f $(PREFIX)/.vimrc
	rm -f $(PREFIX)/.config/nvim/init.vim
	rm -f $(PREFIX)/.config/starship.toml
	rm -f $(PREFIX)/.tmux.conf
