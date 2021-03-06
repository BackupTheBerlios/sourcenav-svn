################################################################################
#
# Simple makefile for building on Mac OS X with the
# Project Builder command line tool 'pbxbuild'
#
# RCS: @(#) $Id$
#
################################################################################

INSTALL_ROOT	=

BUILD_DIR	= ../../build

TARGET		= Wish

DEVBUILDSTYLE	= Development
DEPBUILDSTYLE	= Deployment

PBXBUILD	= /usr/bin/pbxbuild

BUILD		= ${PBXBUILD} SYMROOT="${BUILD_DIR}" -target "${TARGET}"

DEVBUILD	= ${BUILD} -buildstyle "${DEVBUILDSTYLE}"
DEPBUILD	= ${BUILD} -buildstyle "${DEPBUILDSTYLE}"

INSTALLOPTS	= INSTALL_ROOT="${INSTALL_ROOT}"

EMBEDDEDOPTS	= DYLIB_INSTALL_PATH="@executable_path/../Frameworks"

################################################################################

all: develop deploy

install: install-develop install-deploy

embedded: embedded-develop embedded-deploy

install-embedded: install-embedded-develop install-embedded-deploy cleanup-embedded

clean: clean-develop clean-deploy

################################################################################

develop:
	${DEVBUILD}

deploy:
	${DEPBUILD}

install-develop: 
	${DEVBUILD} install ${INSTALLOPTS}

install-deploy:
	${DEPBUILD} install ${INSTALLOPTS}

embedded-develop: 
	${DEVBUILD} ${EMBEDDEDOPTS}

embedded-deploy:
	${DEPBUILD} ${EMBEDDEDOPTS}

install-embedded-develop: 
	${DEVBUILD} install ${INSTALLOPTS} ${EMBEDDEDOPTS}

install-embedded-deploy:
	${DEPBUILD} install ${INSTALLOPTS} ${EMBEDDEDOPTS}

clean-develop:
	${DEVBUILD} clean

clean-deploy:
	${DEPBUILD} clean

################################################################################

cleanup-embedded:
	@( \
	cd ${INSTALL_ROOT}; \
	rm -f Frameworks; \
	rm -rf @executable_path; \
	rm -rf Library/Frameworks/Tcl.framework; \
	rm -rf Library/Frameworks/Tk.framework; \
	if [ -d Library/Frameworks ]; then rmdir -p Library/Frameworks; fi; \
	)

################################################################################
