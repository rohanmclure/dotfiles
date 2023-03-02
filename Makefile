.PHONY: all install clean

LN := ln
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	LN += -sbf
endif
ifeq ($(UNAME_S),Darwin)
	LN += -sf
endif

TARGETS = $(addprefix ${HOME}/,.zshrc .tmux.conf .gitconfig)\
	  $(addprefix ${XDG_CONFIG_HOME}/,bat/config nvim starship.toml)

all:

${HOME}/.zshrc: zshrc
	${LN} $(abspath $<) $@

${HOME}/.tmux.conf: tmux.conf
	${LN} $(abspath $<) $@

${HOME}/.gitconfig: gitconfig
	${LN} $(abspath $<) $@

${XDG_CONFIG_HOME}/bat/config: batrc
	mkdir -p ${XDG_CONFIG_HOME}/bat/ && \
		${LN} $(abspath $<) $@

doom-nvim/config.lua: config.lua
	${LN} $(abspath $<) $@

${XDG_CONFIG_HOME}/nvim: doom-nvim doom-nvim/config.lua
	${LN} $(abspath $<) $@

${XDG_CONFIG_HOME}/starship.toml: starship.toml
	${LN} $(abspath $<) $@

install: ${TARGETS}

clean:
	rm -rf ${TARGETS}
