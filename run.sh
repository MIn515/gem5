

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
./build/RISCV/gem5.opt configs/example/riscv/fs_linux.py --kernel=./image/fw_payload.elf --disk-image=./image/rootfs.ext2 --cpu-type=AtomicSimpleCPU -n=2
