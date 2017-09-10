#!/bin/sh

# Check arguments passed in
if [ $# -lt 2 ] || [ ! -d $1 ] || [ ! -d $2 ]; then
echo "This script patch kernel source"
echo "Usage:  $0 patches_dir kernel_source_dir"
exit 127
fi

cp $1/mach-som9331.c $2/arch/mips/ath79/
cp $1/setup.c $2/arch/mips/ath79/setup.c 
cp $1/dev-m25p80.h $2/arch/mips/ath79/
cp $1/dev-m25p80.c $2/arch/mips/ath79/
cp $1/dev-eth.h $2/arch/mips/ath79/
cp $1/dev-eth.c $2/arch/mips/ath79/
cp $1/dev-wmac.c $2/arch/mips/ath79/
cp $1/dev-wmac.h $2/arch/mips/ath79/
cp $1/ath79_Kconfig  $2/arch/mips/ath79/Kconfig
cp $1/ath79_Makefile $2/arch/mips/ath79/Makefile

#kernel config
cp $1/som9331_config $2/.config

cp $1/ag71xx_platform.h $2/arch/mips/include/asm/mach-ath79/
cp $1/ar71xx_regs.h $2/arch/mips/include/asm/mach-ath79/

cp $1/flash.h $2/include/linux/spi/flash.h
cp $1/ath79_machtypes.h $2/arch/mips/ath79/machtypes.h
cp $1/ath79_spi_platform.h $2/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h  
cp $1/spi-ath79.c $2/drivers/spi/spi-ath79.c
cp $1/spi.h $2/include/linux/spi/spi.h
cp $1/spi-bitbang.c $2/drivers/spi/
cp $1/spi-gpio.c $2/drivers/spi/spi-gpio.c
cp $1/spi_bitbang.h $2/include/linux/spi/spi_bitbang.h

#mtd
cp $1/tplinkpart.c $2/drivers/mtd/
cp $1/mtd_Makefile $2/drivers/mtd/Makefile
cp $1/mtd_Kconfig $2/drivers/mtd/Kconfig
cp $1/mtdsplit* $2/drivers/mtd/
cp $1/mtd.h $2/include/linux/mtd/mtd.h
cp $1/mtdpart.c $2/drivers/mtd/mtdpart.c
cp $1/mtdcore.c $2/drivers/mtd/mtdcore.c
cp $1/partitions.h $2/include/linux/mtd/partitions.h
cp $1/m25p80.c $2/drivers/mtd/devices/m25p80.c
cp $1/xz_wrapper.c $2/fs/squashfs/xz_wrapper.c

#ethernet driver
cp -rf $1/ethernet_driver/atheros $2/drivers/net/ethernet/
cp $1/ethernet_driver/phy.c $2/drivers/net/phy/phy.c
cp $1/ethernet_driver/swconfig.c $2/drivers/net/phy/swconfig.c
cp $1/ethernet_driver/phy_Kconfig $2/drivers/net/phy/Kconfig
cp $1/ethernet_driver/phy_Makefile $2/drivers/net/phy/Makefile

cp $1/ethernet_driver/phy.h $2/include/linux/phy.h
cp $1/ethernet_driver/switch.h $2/include/linux/switch.h
cp $1/ethernet_driver/uapi_switch.h $2/include/uapi/linux/switch.h
