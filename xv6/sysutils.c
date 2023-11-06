#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

// return digital root of number given
int sys_find_digital_root(void)
{
    int n = myproc()->tf->ebx;
    int res = 0;
    while (n > 0)
    {
        res += n % 10;
        n /= 10;
        if (res > 9)
            res -= 9;
    }
    return res;
}