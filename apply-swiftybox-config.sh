#!/bin/bash
# SwiftyλBox BusyBox Configuration Script
# Configures BusyBox for static musl build with Swift integration

set -e

echo "Applying SwiftyλBox configuration to BusyBox..."

# Enable static linking and libbusybox
sed -i 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/' .config
sed -i 's/# CONFIG_BUILD_LIBBUSYBOX is not set/CONFIG_BUILD_LIBBUSYBOX=y/' .config
sed -i 's/# CONFIG_FEATURE_SHARED_BUSYBOX is not set/CONFIG_FEATURE_SHARED_BUSYBOX=y/' .config

# Disable TC (requires kernel headers)
sed -i 's/^CONFIG_TC=y/# CONFIG_TC is not set/' .config

# Disable console-tools (require kernel headers incompatible with musl)
sed -i 's/^CONFIG_CLEAR=y/# CONFIG_CLEAR is not set/' .config
sed -i 's/^CONFIG_DEALLOCVT=y/# CONFIG_DEALLOCVT is not set/' .config
sed -i 's/^CONFIG_DUMPKMAP=y/# CONFIG_DUMPKMAP is not set/' .config
sed -i 's/^CONFIG_FGCONSOLE=y/# CONFIG_FGCONSOLE is not set/' .config
sed -i 's/^CONFIG_KBD_MODE=y/# CONFIG_KBD_MODE is not set/' .config
sed -i 's/^CONFIG_LOADFONT=y/# CONFIG_LOADFONT is not set/' .config
sed -i 's/^CONFIG_LOADKMAP=y/# CONFIG_LOADKMAP is not set/' .config
sed -i 's/^CONFIG_OPENVT=y/# CONFIG_OPENVT is not set/' .config
sed -i 's/^CONFIG_RESET=y/# CONFIG_RESET is not set/' .config
sed -i 's/^CONFIG_RESIZE=y/# CONFIG_RESIZE is not set/' .config
sed -i 's/^CONFIG_SETCONSOLE=y/# CONFIG_SETCONSOLE is not set/' .config
sed -i 's/^CONFIG_SETFONT=y/# CONFIG_SETFONT is not set/' .config
sed -i 's/^CONFIG_SETKEYCODES=y/# CONFIG_SETKEYCODES is not set/' .config
sed -i 's/^CONFIG_SETLOGCONS=y/# CONFIG_SETLOGCONS is not set/' .config
sed -i 's/^CONFIG_SHOWKEY=y/# CONFIG_SHOWKEY is not set/' .config

# Disable ASH builtins - let Swift handle these for NOFORK speedup
sed -i 's/^CONFIG_ASH_BUILTIN_ECHO=y/# CONFIG_ASH_BUILTIN_ECHO is not set/' .config
sed -i 's/^CONFIG_ASH_BUILTIN_PRINTF=y/# CONFIG_ASH_BUILTIN_PRINTF is not set/' .config
sed -i 's/^CONFIG_ASH_BUILTIN_TEST=y/# CONFIG_ASH_BUILTIN_TEST is not set/' .config

# Disable init (requires linux/vt.h)
sed -i 's/^CONFIG_INIT=y$/# CONFIG_INIT is not set/' .config
sed -i 's/^CONFIG_FEATURE_USE_INITTAB=y$/# CONFIG_FEATURE_USE_INITTAB is not set/' .config
sed -i 's/^CONFIG_FEATURE_INITRD=y$/# CONFIG_FEATURE_INITRD is not set/' .config
sed -i 's/^CONFIG_FEATURE_INIT_SWAPON=y$/# CONFIG_FEATURE_INIT_SWAPON is not set/' .config
sed -i 's/^CONFIG_RUN_INIT=y$/# CONFIG_RUN_INIT is not set/' .config

# Disable loop device support (requires linux/version.h)
sed -i 's/^CONFIG_LOSETUP=y$/# CONFIG_LOSETUP is not set/' .config
sed -i 's/^CONFIG_FEATURE_MOUNT_LOOP=y$/# CONFIG_FEATURE_MOUNT_LOOP is not set/' .config
sed -i 's/^CONFIG_FEATURE_MOUNT_LOOP_CREATE=y$/# CONFIG_FEATURE_MOUNT_LOOP_CREATE is not set/' .config

# Disable IP tools (require linux/netlink.h)
sed -i 's/^CONFIG_IP=y$/# CONFIG_IP is not set/' .config
sed -i 's/^CONFIG_IPADDR=y$/# CONFIG_IPADDR is not set/' .config
sed -i 's/^CONFIG_IPLINK=y$/# CONFIG_IPLINK is not set/' .config
sed -i 's/^CONFIG_IPROUTE=y$/# CONFIG_IPROUTE is not set/' .config
sed -i 's/^CONFIG_IPTUNNEL=y$/# CONFIG_IPTUNNEL is not set/' .config
sed -i 's/^CONFIG_IPRULE=y$/# CONFIG_IPRULE is not set/' .config
sed -i 's/^CONFIG_IPNEIGH=y$/# CONFIG_IPNEIGH is not set/' .config
sed -i 's/^CONFIG_FEATURE_IP_ADDRESS=y$/# CONFIG_FEATURE_IP_ADDRESS is not set/' .config
sed -i 's/^CONFIG_FEATURE_IP_LINK=y$/# CONFIG_FEATURE_IP_LINK is not set/' .config
sed -i 's/^CONFIG_FEATURE_IP_ROUTE=y$/# CONFIG_FEATURE_IP_ROUTE is not set/' .config
sed -i 's/^CONFIG_FEATURE_IP_TUNNEL=y$/# CONFIG_FEATURE_IP_TUNNEL is not set/' .config
sed -i 's/^CONFIG_FEATURE_IP_RULE=y$/# CONFIG_FEATURE_IP_RULE is not set/' .config
sed -i 's/^CONFIG_FEATURE_IP_NEIGH=y$/# CONFIG_FEATURE_IP_NEIGH is not set/' .config

# Disable capabilities (requires kernel headers)
sed -i 's/^CONFIG_FEATURE_SETPRIV_CAPABILITIES=y$/# CONFIG_FEATURE_SETPRIV_CAPABILITIES is not set/' .config
sed -i 's/^CONFIG_FEATURE_SETPRIV_CAPABILITY_NAMES=y$/# CONFIG_FEATURE_SETPRIV_CAPABILITY_NAMES is not set/' .config

# Update config with oldconfig
make oldconfig < /dev/null

echo "✅ SwiftyλBox configuration applied successfully"
echo ""
echo "Key features:"
echo "  - Static linking enabled (CONFIG_STATIC=y)"
echo "  - libbusybox.a enabled (CONFIG_BUILD_LIBBUSYBOX=y)"
echo "  - ASH builtins disabled (Swift will handle echo/printf/test)"
echo "  - Kernel-dependent features disabled (init, loop, ip, console-tools)"
echo ""
