#!/system/bin/sh
PROPFILE=true
POSTFSDATA=false
LATESTARTSERVICE=true
# === Init ===
ARCH=$(getprop ro.product.cpu.abi)
API=$(getprop ro.build.version.sdk)
MODPATH=${0%/*}
set_permissions() {
  # The following is the default rule, DO NOT remove
  set_perm_recursive $MODPATH 0 0 0755 0644
  
  set_perm_recursive $MODPATH/system/bin 0 0 0755 0755
  
  # Here are some examples:
  # set_perm_recursive  $MODPATH/system/lib       0     0       0755      0644
  # set_perm  $MODPATH/system/bin/app_process32   0     2000    0755      u:object_r:zygote_exec:s0
  # set_perm  $MODPATH/system/bin/dex2oat         0     2000    0755      u:object_r:dex2oat_exec:s0
  # set_perm  $MODPATH/system/lib/libart.so       0     0       0644
}
set_permissions


ui_print ""
ui_print "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
ui_print "┃ ⚙️  Installing for $ARCH (SDK $API) Device ⚙️"
ui_print "┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫"
ui_print "┃ 📱 Model           : $(getprop ro.product.vendor.model)"
ui_print "┃ 🏷️  Brand           : $(getprop ro.product.vendor.manufacturer)"
ui_print "┃ 📡 Android Version : $(getprop ro.build.version.release)"
ui_print "┃ 🗂️  API Level       : $API"
ui_print "┃ 🧬 Arch            : $ARCH"
ui_print "┃ ⚙️  Processor       : $(uname -m)"
ui_print "┃ 🧩 Hardware        : $(getprop ro.hardware)"
ui_print "┃ ✅ Verified Boot   : $(getprop ro.boot.verifiedbootstate)"
ui_print "┃ ⚡ Bionic CPU      : $(getprop ro.bionic.cpu_variant)"
ui_print "┃ 📚 Vendor API      : $(getprop ro.product.vndk.version) & $(getprop ro.vendor.build.version.sdk)"
ui_print "┃ 📱 Vendor Android  : $(getprop ro.vendor.build.version.release_or_codename)"
ui_print "┃ 🧩 DSU Support     : $(getprop ro.boot.dynamic_partitions)"
ui_print "┃ 🧩 GSI Support     : $(getprop ro.treble.enabled)"
ui_print "┃ 🖼️  EGL             : $(getprop ro.hardware.egl)"
ui_print "┃ ⚙️  Zygote          : $(getprop ro.zygote)"
ui_print "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"