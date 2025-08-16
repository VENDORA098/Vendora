
# service.sh
MODPATH=${0%/*}

# Menunggu sampai boot selesai
until [ "$(getprop sys.boot_completed)" = "1" ]; do
  sleep 1
done

#!/system/bin/sh
# =========================================
# Run kernel_inject.sh sesuai ABI device
# =========================================

MODULE_DIR="/data/adb/modules/VendoraTweak"
BINARY="$MODULE_DIR/kernel_inject"

# Deteksi ABI
DEVICE_ABI=$(getprop ro.product.cpu.abi)
DEVICE_ABI2=$(getprop ro.product.cpu.abilist64)

# Tentukan suffix modul
ABI_SUFFIX=""

if [ "$DEVICE_ABI" = "arm64-v8a" ]; then
    ABI_SUFFIX="arm64"
elif [ "$DEVICE_ABI" = "armeabi-v7a" ]; then
    ABI_SUFFIX="arm32"
fi

# Kondisi khusus: arm32 tapi ada binder arm64
if [ "$DEVICE_ABI" = "armeabi-v7a" ] && [ -n "$DEVICE_ABI2" ]; then
    ABI_SUFFIX="arm32"
fi

# Tentukan file binary final
FINAL_BINARY="$BINARY"_"$ABI_SUFFIX"

# Cek dan jalankan
if [ -f "$FINAL_BINARY" ]; then
    chmod 755 "$FINAL_BINARY"
    echo "✅ Permission set: $FINAL_BINARY -> 755"
    echo "🚀 Executing kernel_inject binary..."
    "$FINAL_BINARY"
else
    echo "❌ Kernel inject binary not found: $FINAL_BINARY"
    exit 1
fi