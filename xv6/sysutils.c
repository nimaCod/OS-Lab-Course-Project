#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"
#include "sysutils.h"

struct prioritylock lock;
struct spinlock lock2;
struct sharedmem main_mem;

void initmem(struct sharedmem *my_mem)
{
    initlock(&my_mem->lock, "shared mem");
    my_mem->page_count = 0;
    my_mem->pages = 0;
}

void utylinit(void)
{
    p_initlock(&lock, "utyls");
    // initlock(&lock2, "u");
    initmem(&main_mem);
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

uint sum = 0;
void do_temp()
{
    for (int i = 0; i < 1000000000; i++)
    {
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

void *sys_open_sharedmem(void)
{
    int id;
    if ((argstr(0, &id)) < 0)
        return 0;
}

int sys_close_sharedmem(void)
{
    int id;
    if ((argstr(0, &id)) < 0)
        return -1;
}
