#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        printf(2, "not good args : %d!\n", argc);
        exit();
    }

    int prev;

    asm volatile(
        "movl %%ebx , %0\n\t"
        "movl %1, %%ebx"
        : "=r"(prev)
        : "r"(atoi(argv[1])));

    int res = find_digital_root();

    asm volatile(
        "movl %0, %%ebx" ::"r"(prev));

    printf(1, "FDR : %d\n", res);

    exit();
}