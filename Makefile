BUILD=build/

SUBDIRS=	protocol	\
		libs		\
		clients		\
		server		\
		streaming-agent

-include autogen.mk
include $(BUILD)rules.mk

$(BUILD)rules.mk:
	git submodule update --init --recursive

all install: $(AUTOGEN:%=%.autogen)

gitclean distclean restore: $(AUTOGEN:%=%.autorestore)
	$(PRINT_COMMAND) git clean -dfx
	$(PRINT_COMMAND) git submodule foreach 'git clean -dfx'

%.autogen:
	cd $* && make $(MAKECMDGOAL)
%.autorestore:
	cd $* && for I in `git status | grep -i 'modified:.*Makefile' | sed -e 's|modified:||g' `; do echo Restoring $$I in $* ; git checkout $$I; done
