include $(TOPDIR)/rules.mk

PKG_NAME:=relayd
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://git.openwrt.org/project/relayd.git
PKG_SOURCE_DATE:=2020-04-25
PKG_SOURCE_VERSION:=f4d759be7e0206a74b7d08c7bcca1232e1c4f520
PKG_MIRROR_HASH:=skip

PKG_MAINTAINER:=Felix Fietkau <nbd@nbd.name>
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/relayd
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Transparent LAN/WLAN/WWAN relay daemon
  URL:=https://openwrt.org/docs/guide-user/network/wifi/relay_configuration
  DEPENDS:=+libc +libssp
endef

define Package/relayd/description
  relayd allows transparent routing / relaying between LAN, WLAN and WWAN
  interfaces by spoofing ARP and DHCP.
endef

define Package/relayd/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/relayd $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/relayd.config $(1)/etc/config/relayd
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/relayd.init $(1)/etc/init.d/relayd
endef

$(eval $(call BuildPackage,relayd))
