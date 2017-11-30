BUILD=build/

SUBDIRS=	protocol	\
		libs		\
		clients		\
		server		\
		streaming-agent

include $(BUILD)rules.mk

$(BUILD)rules.mk:
	git submodule update --init --recursive

gitclean:
	$(PRINT_COMMAND) git clean -dfx
	$(PRINT_COMMAND) git submodule foreach 'git clean -dfx'
