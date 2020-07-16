arch=`uname -m`
SB_ID="${1:-0}" # Default to sb_id=0
KERNEL_BOOT_ARGS="console=ttyS0 reboot=k panic=1 pci=off nomodules ipv6.disable=1"
#KERNEL="$PWD/vmlinux"
KERNEL="$PWD/vmlinux.bin"

echo $SB_ID
FC_IP="172.16.0.2"
TAP_IP="172.16.0.1"
FC_MAC="$(printf '02:FC:00:00:%02X:%02X' $((SB_ID / 256)) $((SB_ID % 256)))"
KERNEL_BOOT_ARGS="${KERNEL_BOOT_ARGS} ip=${FC_IP}::${TAP_IP}:${MASK_LONG}::eth0:off"

curl --unix-socket /tmp/firecracker.socket -i \
-X PUT 'http://localhost/boot-source'   \
-H 'Accept: application/json'           \
-H 'Content-Type: application/json'     \
-d "{
      \"kernel_image_path\": \"${KERNEL}\",
      \"boot_args\": \"${KERNEL_BOOT_ARGS}\"
 }"
