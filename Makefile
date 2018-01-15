GLUON_BUILD_DIR := gluon-build
GLUON_GIT_URL := https://github.com/freifunk-gluon/gluon
GLUON_GIT_REF := 3d824bd21d7f6d5db6dc238d2a68b62de471aa2a

#https://github.com/freifunk-gluon/gluon/commit/6b8888fe5aebd941c5e7a83a97ceb0678bee4c43

SECRET_KEY_FILE ?= ${HOME}/.gluon-secret-key

GLUON_TARGETS ?= \
	ar71xx-generic \
	ar71xx-nand \
	brcm2708-bcm2708 \
	brcm2708-bcm2709 \
	mpc85xx-generic \
	ramips-mt7621 \
	ramips-rt305x \
	x86-64 \
	x86-generic \
	sunxi \
	x86-kvm_guest


GLUON_RELEASE := $(shell git describe --tags 2>/dev/null)
ifneq (,$(shell git describe --exact-match --tags 2>/dev/null))
  GLUON_BRANCH := stable
else
  GLUON_BRANCH := experimental
endif

JOBS ?= $(shell cat /proc/cpuinfo | grep processor | wc -l)

#JOBS = 1

GLUON_MAKE := ${MAKE} V=s BROKEN=0 -j ${JOBS} -C ${GLUON_BUILD_DIR} \
			GLUON_RELEASE=${GLUON_RELEASE} \
			GLUON_BRANCH=${GLUON_BRANCH} \


all: info
	${MAKE} manifest

info:
	@echo
	@echo '#########################'
	@echo '# FFRGB Firmare build'
	@echo '# Building release ${GLUON_RELEASE} for branch ${GLUON_BRANCH}'
	@echo '# make params: ${GLUON_MAKE}'
	@echo

build: gluon-prepare
	for target in ${GLUON_TARGETS}; do \
		echo ""Building target $$target""; \
		${GLUON_MAKE} GLUON_TARGET="$$target"; \
	done

buildonly:
	for target in ${GLUON_TARGETS}; do \
                echo ""Building target $$target""; \
                ${GLUON_MAKE} GLUON_TARGET="$$target"; \
	done


manifest: build
	${GLUON_MAKE} manifest
	mv ${GLUON_BUILD_DIR}/output .

sign: manifest
	${GLUON_BUILD_DIR}/contrib/sign.sh ${SECRET_KEY_FILE} images/sysupgrade/${GLUON_BRANCH}.manifest

${GLUON_BUILD_DIR}:
	git clone ${GLUON_GIT_URL} ${GLUON_BUILD_DIR}

gluon-prepare: images-clean ${GLUON_BUILD_DIR}
	(cd ${GLUON_BUILD_DIR} \
	  && git remote set-url origin ${GLUON_GIT_URL} \
	  && git fetch origin \
	  && git checkout -q ${GLUON_GIT_REF})
	ln -sfT .. ${GLUON_BUILD_DIR}/site
	${GLUON_MAKE} update

gluon-clean:
	rm -rf ${GLUON_BUILD_DIR}

images-clean:
	rm -rf images

clean: gluon-clean images-clean
