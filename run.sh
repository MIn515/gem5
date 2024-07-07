
#! /bin/bash

# Building gem5 separately
# ===
#
# git clone https://github.com/gem5/gem5
# cd gem5
# git checkout v23.0.0.0
# python3 `which scons` build/RISCV/gem5.opt
#
#
# sudo apt install build-essential git m4 scons zlib1g zlib1g-dev libprotobuf-dev protobuf-compiler libprotoc-dev libgoogle-perftools-dev python-dev python
#
#
# delete result of scons :
# scons -c

#cp /home/xtee/mytee/dev-keystone/keystone-lastcmakeversion/build/sm.build/platform/generic/firmware/fw_payload.elf /home/xtee/mytee/FIMI-TEE/gem5/image/fs/fw_payload.elf

#cp /home/xtee/mytee/dev-keystone/keystone-lastcmakeversion/build/buildroot.build/images/rootfs.ext2  /home/xtee/mytee/FIMI-TEE/gem5/image/fs/rootfs.ext2

#./build/RISCV/gem5.opt configs/example/riscv/fs_linux.py --kernel=/home/xtee/mytee/FIMI-TEE/gem5/image/fs/fw_payload.elf --disk-image=/home/xtee/mytee/FIMI-TEE/gem5/image/fs/rootfs.ext2 --cpu-type=MinorCPU -n=4 --mem-size=512MB --l1d_size=64kB --l1i_size=32kB --caches

## run

if [ $# -eq 0 ]; then
    set -- "se"
fi

# Determine script path (do not resolve symbolic links, we want it as given by the user)

SCRIPT_PATH="${BASH_SOURCE[0]}"
cd `dirname ${SCRIPT_PATH}`
GEM5_DIR=`pwd`;

case "$1" in
    se)
        ./build/RISCV/gem5.opt configs/example/se.py --cmd=${GEM5_DIR}/image/se/eapp-fakesys
        ;;
    fs)
        # ./build/RISCV/gem5.opt configs/example/riscv/fs_linux.py --kernel=${GEM5_DIR}/image/fs/fw_payload.elf --disk-image=${GEM5_DIR}/image/fs/rootfs.ext2 --cpu-type=AtomicSimpleCPU -n=2

	./build/RISCV/gem5.opt configs/example/riscv/fs_linux.py --kernel=${GEM5_DIR}/image/fs/fw_payload.elf --disk-image=${GEM5_DIR}/image/fs/rootfs.ext2 --cpu-type AtomicSimpleCPU --cpu-clock 2GHz -n 1 --mem-size 2GB 

	# ./build/RISCV/gem5.opt configs/example/riscv/fs_linux.py --kernel=${GEM5_DIR}/image/fs/fw_payload.elf --disk-image=${GEM5_DIR}/image/fs/rootfs.ext2 --cpu-type=O3CPU -n=4 --mem-size 512MB --caches
        ;;
    *)
        echo "error：unsupported arguments。" >&2
        exit 1
        ;;
esac
