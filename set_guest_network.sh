SB_ID="${1:-0}" # Default to sb_id=0
TAP_DEV="fc-${SB_ID}-tap0"
MASK_LONG="255.255.255.252"
#MASK_SHORT="/30"
FC_IP="172.16.0.2"
TAP_IP="172.16.0.1"
FC_MAC="$(printf '02:FC:00:00:%02X:%02X' $((SB_ID / 256)) $((SB_ID % 256)))"

curl -X PUT \
  --unix-socket /tmp/firecracker.socket \
  -X PUT 'http://localhost/network-interfaces/1' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -d "{
      \"iface_id\": \"1\",
      \"guest_mac\": \"$FC_MAC\",
      \"host_dev_name\": \"$TAP_DEV\",
      \"allow_mmds_requests\": true
    }"
