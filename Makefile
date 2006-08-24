TOP = ..
include $(TOP)/mk/boilerplate.mk
-include config.mk

ifneq "$(findstring clean, $(MAKECMDGOALS))" ""
# if we're cleaning, then config.mk might have been cleaned already
PACKAGE=regex-posix
endif

ifneq "$(HavePosixRegex)" "YES"
SUBDIRS = cbits
endif

ALL_DIRS = \
	Text/Regex \
	Text/Regex/Posix

PACKAGE_DEPS = base regex-base

SRC_CC_OPTS += -Iinclude
SRC_HC_OPTS += -cpp -fffi
SRC_HC_OPTS += -Iinclude
SRC_HSC2HS_OPTS += -Iinclude

EXCLUDED_SRCS += Setup.hs

PACKAGE_CPP_OPTS += -DMAINTAINER=$(MAINTAINER)

SRC_HADDOCK_OPTS += -t "Haskell Hierarchical Libraries ($(PACKAGE) package)"

ifneq "$(HavePosixRegex)" "YES"
INSTALL_INCLUDES += include/regex/regex.h
endif

DIST_CLEAN_FILES += config.cache config.status config.mk

extraclean::
	$(RM) -rf autom4te.cache

include $(TOP)/mk/target.mk
