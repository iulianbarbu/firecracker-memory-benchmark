#rootfs_path=$PWD"/eth_tool.ext4"
#rootfs_path=$PWD"/hello-rootfs.ext4"
#rootfs_path="$PWD/ubuntu-xenial-16.04.rootfs.ext4"
rootfs_path="$PWD/alpine.rootfs.ext4"
#rootfs_path=$PWD"/xenial.rootfs.ext4"
curl --unix-socket /tmp/firecracker.socket -i \
-X PUT 'http://localhost/drives/rootfs' \
-H 'Accept: application/json'           \
-H 'Content-Type: application/json'     \
-d "{
  \"drive_id\": \"rootfs\",
  \"path_on_host\": \"${rootfs_path}\",
  \"is_root_device\": true,
  \"is_read_only\": false
}"
