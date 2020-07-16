curl --unix-socket /tmp/firecracker.socket -i \
-X PUT 'http://localhost/machine-config'   \
-H 'Accept: application/json'           \
-H 'Content-Type: application/json'     \
-d "{
    \"vcpu_count\": 8,
    \"mem_size_mib\": 3072,
    \"ht_enabled\": false
  }"
