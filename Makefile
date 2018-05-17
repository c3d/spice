MIQ=make-it-quick/

export SPICE_PROTOCOL=$(abspath protocol)/
export SPICE_COMMON=$(abspath common)/

SUBDIRS=	protocol	\
		common		\
		clients		\
		server		\
		streaming-agent

-include autogen.mk
include $(MIQ)rules.mk

$(MIQ)rules.mk:
	git submodule update --init --recursive

all install: $(AUTOGEN:%=%.autogen)

gitclean restore: $(AUTOGEN:%=%.autorestore)
	$(PRINT_COMMAND) git clean -dfx
	$(PRINT_COMMAND) git submodule foreach 'git clean -dfx'
distclean: gitclean

help:	top-level-help
top-level-help:
	@echo "Specific top-level target:"
	@echo "  make gitclean		: Cleanup recursively using git clean"
	@echo "  make restore		: Restore the c3d/build build system"
	@echo "Using autoconf:"
	@echo "  ./autogen.sh		: Run autoconf in all submodules"
	@echo "  ./autogen.sh 'make -j'	: Run autogen and make submodules"
	@echo "  (After this, 'make' builds using auto-generated makefiles)"

%.autogen:
	cd $* && make $(MAKECMDGOAL)
%.autorestore:
	cd $* && for I in `git status | grep -i 'modified:.*Makefile' | sed -e 's|modified:||g' `; do echo Restoring $$I in $* ; git checkout $$I; done
