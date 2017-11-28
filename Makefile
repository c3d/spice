BUILD=build/

SUBDIRS=	protocol	\
		libs		\
		clients		\
		server

include $(BUILD)rules.mk

$(BUILD)rules.mk:
	git submodule update --init --recursive
