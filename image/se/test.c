// a test for gem5 pkru
#include <stdio.h>
#include <stdint.h>

#define UPKRU_CSR 0x048

void write_upkru(uint64_t value) {
    asm volatile (
        "csrrw x0, %[csr], %[val]"
        : 
        : [csr] "i" (UPKRU_CSR),[val] "r" (value)
    );
}

uint64_t read_upkru() {
    uint64_t value;
    asm volatile (
        "csrrs %[val], %[csr], x0" 
        :[val] "=r" (value)
        :[csr] "i" (UPKRU_CSR)
    );
    return value;
}

int main() {

    uint64_t upkru_old_value = read_upkru();
    printf("UPKRU Register Value: 0x%llx\n", upkru_old_value);
    write_upkru(0xFFFFFFFFFFFFFFFF);
    printf("finish write\n");
    uint64_t upkru_value = read_upkru();
    printf("UPKRU Register Value: 0x%llx\n", upkru_value);
    return 0;
}

