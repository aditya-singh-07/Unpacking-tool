#
# Unpacking & repacking v1.0 by aditya  			 
extractdir=./port		 
rominfo=$extractdir/rom-detail
#functions
print(){
	echo "$1"
}
getprop() { grep "$1" "$2" | cut -d "=" -f 2; }
if [ -d $extractdir/system/system ]; then
system=system/system
systemroot=true
else
system=system
systemroot=false
fi;

#
		  
case $1 in rom-detail)
if [ $(grep -q secure=0 $extractdir/vendor/default.prop) ]; then dmverity=true;
elif [ $(grep forceencrypt $extractdir/vendor/etc/fstab.qcom) ]; then dmverity=true;
elif [ $(grep forcefdeorfbe $extractdir/vendor/etc/fstab.qcom) ]; then dmverity=true;
elif [ $(grep fileencryption $extractdir/vendor/etc/fstab.qcom) ]; then dmverity=true;
elif [ $(grep .dmverity=true $extractdir/vendor/etc/fstab.qcom) ]; then dmverity=true;
elif [ $(grep fileencryption $extractdir/vendor/etc/fstab.qcom) ]; then dmverity=true;
																	
else
dmverity=false
fi;
echo "- Android Version = $(getprop ro.build.version.release $extractdir/$system/build.prop) "
echo "- Name ROM        = $(getprop ro.product.system.name $extractdir/$system/build.prop) "
echo "- Model           = $(getprop ro.product.system.model $extractdir/$system/build.prop) "
echo "- Device          = $(getprop ro.product.vendor.device $extractdir/vendor/build.prop) "
echo "- Fingerprint     = $(getprop ro.system.build.fingerprint $extractdir/$system/build.prop) "
echo "- System as-root  = $systemroot "
echo "- Dm-verity       = $dmverity "
;;
esac	
