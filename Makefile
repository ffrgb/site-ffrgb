GLUON_BUILD_DIR := gluon-build
GLUON_GIT_URL := https://github.com/freifunk-gluon/gluon
GLUON_GIT_REF := v2021.1.1

SECRET_KEY_FILE ?= ${HOME}/.gluon-secret-key


GLUON_TARGETS ?= \
        x86-generic \
	ar71xx-generic \
	ar71xx-tiny \
	ar71xx-nand \
	ath79-generic \
	brcm2708-bcm2708 \
	brcm2708-bcm2709 \
	ipq806x-generic \
	lantiq-xrx200 \
	lantiq-xway \
	mpc85xx-generic \
	mpc85xx-p1020 \
	ramips-mt7620 \
	ramips-mt7621 \
	ramips-mt76x8 \
	ramips-rt305x \
	ipq40xx-generic \
	sunxi-cortexa7 \
	x86-64 \
	x86-generic \
	x86-geode \


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
