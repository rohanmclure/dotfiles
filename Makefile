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

TARGETS := $(addprefix $(PREFIX)/,.config/nvim/init.lua .config/nvim/lua .zshrc \
	   			  .tmux.conf .config/starship.toml .config/bat/config \
				  .gitconfig .config/colourscheme)

install: $(TARGETS)

$(PREFIX)/.zshrc: zshrc
	${LN} $(abspath $<) $@

$(PREFIX)/.config/bat/config: batrc
	mkdir -p $(PREFIX)/.config/bat/ && \
		${LN} $(abspath $<) $@

$(PREFIX)/.config/nvim/init.lua: NvChad/init.lua
	${LN} $(abspath $<) $@

$(PREFIX)/.config/nvim/lua: NvChad/lua
	${LN} $(abspath $<) $@

$(PREFIX)/.config/starship.toml: starship.toml
	mkdir -p $(PREFIX)/.config/ && \
		${LN} $(abspath $<) $@

$(PREFIX)/.gitconfig: gitconfig
	${LN} $(abspath $<) $@

$(PREFIX)/.tmux.conf: tmux.conf
	${LN} $(abspath $<) $@

$(PREFIX)/.config/colourscheme:
	mkdir -p $(PREFIX)/.config/ && \
		echo "dark" | tee $@ > /dev/null

clean:
	rm -f $(PREFIX)/.zshrc
	rm -f $(PREFIX)/.vimrc
	rm -f $(PREFIX)/.config/nvim/init.vim
	rm -f $(PREFIX)/.config/starship.toml
	rm -f $(PREFIX)/.tmux.conf
