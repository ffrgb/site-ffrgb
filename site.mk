GLUON_MULTIDOMAIN=1
GLUON_DEPRECATED ?= upgrade

GLUON_FEATURES := \
	autoupdater \
	config-mode-domain-select \
	config-mode-geo-location-osm \
	config-mode-mesh-vpn \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	ebtables-source-filter \
	mesh-batman-adv-15 \
	respondd \
	status-page \
	web-advanced \
	web-private-wifi \
	web-wizard


# base packages
GLUON_SITE_PACKAGES := \
	gluon-segment-mover \
	iwinfo \
	gluon-ssid-changer \
	respondd-module-airtime \
	gluon-mesh-vpn-wireguard-vxlan \
	ffrgb-banner 

DEFAULT_GLUON_RELEASE := snapshot~$(shell date '+%Y%m%d')
# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)
GLUON_PRIORITY ?= 0
GLUON_REGION ?= eu
GLUON_LANGS ?= en de

# additional packages

INCLUDE_USB := \
    usbutils

EXCLUDE_USB := \
    -usbutils

INCLUDE_USB_HID := \
    kmod-usb-hid \
    kmod-hid-generic

EXCLUDE_USB_HID := \
    -kmod-usb-hid \
    -kmod-hid-generic

INCLUDE_USB_SERIAL := \
    kmod-usb-serial \
    kmod-usb-serial-ftdi \
    kmod-usb-serial-pl2303

EXCLUDE_USB_SERIAL := \
    -kmod-usb-serial \
    -kmod-usb-serial-ftdi \
    -kmod-usb-serial-pl2303

INCLUDE_USB_STORAGE := \
    block-mount \
    blkid \
    kmod-fs-ext4 \
    kmod-fs-ntfs \
    kmod-fs-vfat \
    kmod-usb-storage \
    kmod-usb-storage-extras \
    kmod-usb-storage-uas \
    kmod-nls-base \
    kmod-nls-cp1250 \
    kmod-nls-cp437 \
    kmod-nls-cp850 \
    kmod-nls-cp852 \
    kmod-nls-iso8859-1 \
    kmod-nls-iso8859-13 \
    kmod-nls-iso8859-15 \
    kmod-nls-iso8859-2 \
    kmod-nls-utf8

EXCLUDE_USB_STORAGE := \
    -block-mount \
    -blkid \
    -kmod-fs-ext4 \
    -kmod-fs-ntfs \
    -kmod-fs-vfat \
    -kmod-usb-storage \
    -kmod-usb-storage-extras \
    -kmod-usb-storage-uas \
    -kmod-nls-base \
    -kmod-nls-cp1250 \
    -kmod-nls-cp437 \
    -kmod-nls-cp850 \
    -kmod-nls-cp852 \
    -kmod-nls-iso8859-1 \
    -kmod-nls-iso8859-13 \
    -kmod-nls-iso8859-15 \
    -kmod-nls-iso8859-2 \
    -kmod-nls-utf8

INCLUDE_USB_NET := \
    kmod-mii \
    kmod-usb-net \
    kmod-usb-net-asix \
    kmod-usb-net-asix-ax88179 \
    kmod-usb-net-cdc-eem \
    kmod-usb-net-cdc-ether \
    kmod-usb-net-cdc-subset \
    kmod-usb-net-dm9601-ether \
    kmod-usb-net-hso \
    kmod-usb-net-ipheth \
    kmod-usb-net-mcs7830 \
    kmod-usb-net-pegasus \
    kmod-usb-net-rndis \
    kmod-usb-net-rtl8152 \
    kmod-usb-net-smsc95xx

EXCLUDE_USB_NET := \
    -kmod-mii \
    -kmod-usb-net \
    -kmod-usb-net-asix \
    -kmod-usb-net-asix-ax88179 \
    -kmod-usb-net-cdc-eem \
    -kmod-usb-net-cdc-ether \
    -kmod-usb-net-cdc-subset \
    -kmod-usb-net-dm9601-ether \
    -kmod-usb-net-hso \
    -kmod-usb-net-ipheth \
    -kmod-usb-net-mcs7830 \
    -kmod-usb-net-pegasus \
    -kmod-usb-net-rndis \
    -kmod-usb-net-rtl8152 \
    -kmod-usb-net-smsc95xx

INCLUDE_PCI := \
    pciutils

EXCLUDE_PCI := \
    -pciutils

INCLUDE_PCI_NET := \
    kmod-bnx2

EXCLUDE_PCI_NET := \
    -kmod-bnx2

INCLUDE_TLS := \
    ca-bundle \
    libustream-openssl

EXCLUDE_TLS := \
    -ca-bundle \
    -libustream-openssl

ifeq ($(GLUON_TARGET),ath79-generic)
    GLUON_SITE_PACKAGES += $(INCLUDE_TLS)
    GLUON_devolo-wifi-pro-1750e_SITE_PACKAGES += $(INCLUDE_USB) $(INCLUDE_USB_NET) $(INCLUDE_USB_SERIAL) $(INCLUDE_USB_STORAGE)
    GLUON_gl.inet-gl-ar150_SITE_PACKAGES += $(INCLUDE_USB) $(INCLUDE_USB_NET) $(INCLUDE_USB_SERIAL) $(INCLUDE_USB_STORAGE)
    GLUON_gl.inet-gl-ar300m-lite_SITE_PACKAGES += $(INCLUDE_USB) $(INCLUDE_USB_NET) $(INCLUDE_USB_SERIAL) $(INCLUDE_USB_STORAGE)
    GLUON_gl.inet-gl-ar750_SITE_PACKAGES += $(INCLUDE_USB) $(INCLUDE_USB_NET) $(INCLUDE_USB_SERIAL) $(INCLUDE_USB_STORAGE)
    GLUON_joy-it-jt-or750i_SITE_PACKAGES += $(INCLUDE_USB) $(INCLUDE_USB_NET) $(INCLUDE_USB_SERIAL) $(INCLUDE_USB_STORAGE)
    GLUON_netgear-wndr3700-v2_SITE_PACKAGES += $(INCLUDE_USB) $(INCLUDE_USB_NET) $(INCLUDE_USB_SERIAL) $(INCLUDE_USB_STORAGE)
    GLUON_tp-link-archer-a7-v5_SITE_PACKAGES += $(INCLUDE_USB) $(INCLUDE_USB_NET) $(INCLUDE_USB_SERIAL) $(INCLUDE_USB_STORAGE)
    GLUON_tp-link-archer-c5-v1_SITE_PACKAGES += $(INCLUDE_USB) $(INCLUDE_USB_NET) $(INCLUDE_USB_SERIAL) $(INCLUDE_USB_STORAGE)
    GLUON_tp-link-archer-c7-v2_SITE_PACKAGES += $(INCLUDE_USB) $(INCLUDE_USB_NET) $(INCLUDE_USB_SERIAL) $(INCLUDE_USB_STORAGE)
    GLUON_tp-link-archer-c7-v5_SITE_PACKAGES += $(INCLUDE_USB) $(INCLUDE_USB_NET) $(INCLUDE_USB_SERIAL) $(INCLUDE_USB_STORAGE)
    GLUON_tp-link-archer-c59-v1_SITE_PACKAGES += $(INCLUDE_USB) $(INCLUDE_USB_NET) $(INCLUDE_USB_SERIAL) $(INCLUDE_USB_STORAGE)
    GLUON_tp-link-tl-wr842n-v3_SITE_PACKAGES += $(INCLUDE_USB) $(INCLUDE_USB_NET) $(INCLUDE_USB_SERIAL) $(INCLUDE_USB_STORAGE)
    GLUON_tp-link-tl-wr1043nd-v4_SITE_PACKAGES += $(INCLUDE_USB) $(INCLUDE_USB_NET) $(INCLUDE_USB_SERIAL) $(INCLUDE_USB_STORAGE)
    GLUON_d-link-dir825b1_SITE_PACKAGES += $(EXCLUDE_TLS)
    GLUON_tp-link-re355-v1_SITE_PACKAGES += $(EXCLUDE_TLS)
    GLUON_tp-link-re450-v1_SITE_PACKAGES += $(EXCLUDE_TLS)
endif

# no pkglists for target ath79-mikrotik


ifeq ($(GLUON_TARGET),ath79-nand)
    GLUON_SITE_PACKAGES += $(INCLUDE_TLS) $(INCLUDE_USB) $(INCLUDE_USB_NET) $(INCLUDE_USB_SERIAL) $(INCLUDE_USB_STORAGE)

endif

ifeq ($(GLUON_TARGET),bcm27xx-bcm2708)
    GLUON_SITE_PACKAGES += $(INCLUDE_TLS) $(INCLUDE_USB) $(INCLUDE_USB_HID) $(INCLUDE_USB_NET) $(INCLUDE_USB_SERIAL) $(INCLUDE_USB_STORAGE)

endif
