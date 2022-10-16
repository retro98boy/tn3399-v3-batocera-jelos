################################################################################
#
# uboot files for tn3399_v3
#
################################################################################
UBOOT_TN3399_V3_VERSION = c8c27b14fbab393d7292f26bc13cdf8391cb814b
UBOOT_TN3399_V3_SITE = https://github.com/retro98boy/u-boot-bin-tn3399_v3.git
UBOOT_TN3399_V3_SITE_METHOD=git

define UBOOT_TN3399_V3_INSTALL_TARGET_CMDS
	mkdir -p   $(BINARIES_DIR)/tn3399_v3/
	cp $(@D)/* $(BINARIES_DIR)/tn3399_v3/
endef

$(eval $(generic-package))
