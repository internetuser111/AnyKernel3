# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=DragonHeart for OnePlus 7 by cyberknight777 @ xda-developers
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=guacamole
device.name2=guacamoleb
device.name3=hotdog
device.name4=hotdogb
device.name5=hotdogg
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=1;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;

# select the correct image to flash
fstype="$(mount | grep -wom1 sdcardfs)"
case $fstype in
    sdcardfs)
	os="sdcardfs"
	;;
    *)
	os="non-sdcardfs"
	;;
esac
ui_print " " "You are on a $os ROM!";
mv $home/kernels/$os/Image.gz-dtb $home/Image.gz-dtb;

## AnyKernel boot install
dump_boot;

write_boot;
## end install
