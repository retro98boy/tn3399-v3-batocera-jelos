################################################################################
#
# tn3399_v3-blobs
#
################################################################################

TN3399_V3_BLOBS_VERSION = 3d2e4a5a979a2c6e6b60ae76b814686b227d0588
TN3399_V3_BLOBS_SITE = https://github.com/retro98boy/u-boot-bin-tn3399_v3.git
TN3399_V3_BLOBS_SITE_METHOD=git

define TN3399_V3_BLOBS_INSTALL_TARGET_CMDS
	cp $(@D)/u-boot-tn3399_v3.bin $(BINARIES_DIR)/u-boot-tn3399_v3.bin
endef

$(eval $(generic-package))
