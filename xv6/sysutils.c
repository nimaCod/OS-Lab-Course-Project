#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"

struct prioritylock lock;
struct spinlock lock2;

void utylinit(void)
{
    p_initlock(&lock, "utyls");
    // initlock(&lock2, "u");
}

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


uint sum=0;
void do_temp()
{
    for (int i = 0; i < 1000000000; i++){
        sum += i;
    }
}

int sys_aq(void)
{
    cprintf("proccess entered queue : %d\n", myproc()->pid);

    prior_acquire(&lock);
    cprintf("proccess entered critical : %d\n", myproc()->pid);
    // acquire(&lock2);
    do_temp();
    cprintf("proccess exit : %d\n", myproc()->pid);
    p_release(&lock);
    // release(&lock2);
    return 0;
}
