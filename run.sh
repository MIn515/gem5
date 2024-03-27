
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
        ./build/RISCV/gem5.opt configs/example/se.py --cmd=${GEM5_DIR}/image/se/test
        ;;
    fs)
        ./build/RISCV/gem5.opt configs/example/riscv/fs_linux.py --kernel=${GEM5_DIR}/image/fs/fw_payload.elf --disk-image=${GEM5_DIR}/image/fs/rootfs.ext2 --cpu-type=AtomicSimpleCPU -n=2
        ;;
    *)
        echo "错误：不支持的参数。" >&2
        exit 1
        ;;
esac
