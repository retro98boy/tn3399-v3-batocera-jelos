################################################################################
#
# uboot files for TN3399_V3
#
################################################################################
UBOOT_TN3399_V3_VERSION = 326cc3a3f5994340037394eef20b39d24b1cf93e
UBOOT_TN3399_V3_SITE = https://github.com/retro98boy/u-boot-bin-tn3399_v3.git
UBOOT_TN3399_V3_SITE_METHOD=git

define UBOOT_TN3399_V3_INSTALL_TARGET_CMDS
	mkdir -p   $(BINARIES_DIR)/tn3399_v3/
	cp $(@D)/* $(BINARIES_DIR)/tn3399_v3/
endef

$(eval $(generic-package))
