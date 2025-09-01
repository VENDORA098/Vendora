#!/system/bin/sh

MODULE_DIR="/data/adb/modules/VendoraTweak"
BINARY="$MODULE_DIR/kernel_inject"

DEVICE_ABI=$(getprop ro.product.cpu.abi)
DEVICE_ABI2=$(getprop ro.product.cpu.abilist64)

ABI_SUFFIX=""
if [ "$DEVICE_ABI" = "arm64-v8a" ]; then
    ABI_SUFFIX="arm64"
elif [ "$DEVICE_ABI" = "armeabi-v7a" ]; then
    ABI_SUFFIX="arm32"
fi

FINAL_BINARY="$BINARY"_"$ABI_SUFFIX.sh"
if [ -f "$FINAL_BINARY" ]; then
    chmod 755 "$FINAL_BINARY"
    echo "✅ Permission set: $FINAL_BINARY.sh -> 755"
    echo "🚀 Executing kernel_inject binary..."
    
    nohup "$FINAL_BINARY" &
    PID=$!
    echo "🔹 PID: $PID"

    # Set OOM score agar tidak mudah ke-kill
    echo -1000 > /proc/$PID/oom_score_adj
    logcat -s Vendora
else
    echo "❌ Kernel inject binary not found: $FINAL_BINARY.sh"
    exit 1
fi