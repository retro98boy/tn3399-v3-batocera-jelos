################################################################################
#
# firmware-tn3399_v3
#
################################################################################

FIRMWARE_TN3399_V3_VERSION = 635b1c1a7c2218c1912090962cad7942380600f8
FIRMWARE_TN3399_V3_SITE = $(call github,retro98boy,linux-tn3399_v3,$(FIRMWARE_TN3399_V3_VERSION))

FIRMWARE_TN3399_V3_TARGET_DIR=$(TARGET_DIR)/lib/firmware/brcm

define FIRMWARE_TN3399_V3_INSTALL_TARGET_CMDS
	mkdir -p $(FIRMWARE_ROCKPRO64_TARGET_DIR)
	cp -r $(@D)/AP6255固件/mainline/BCM4345C0.hcd					$(FIRMWARE_TN3399_V3_TARGET_DIR)/
	cp -r $(@D)/AP6255固件/mainline/brcmfmac43455-sdio.txt				$(FIRMWARE_TN3399_V3_TARGET_DIR)/
	cp -r $(@D)/AP6255固件/mainline/brcmfmac43455-sdio.bin				$(FIRMWARE_TN3399_V3_TARGET_DIR)/
	cp -r $(@D)/AP6255固件/mainline/brcmfmac43455-sdio.rockchip,tn3399_v3.txt	$(FIRMWARE_TN3399_V3_TARGET_DIR)/
	cp -r $(@D)/AP6255固件/mainline/brcmfmac43455-sdio.rockchip,tn3399_v3.bin	$(FIRMWARE_TN3399_V3_TARGET_DIR)/
endef

$(eval $(generic-package))
