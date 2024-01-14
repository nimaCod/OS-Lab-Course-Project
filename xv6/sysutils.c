#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "sysutils.h"

struct prioritylock lock;
struct spinlock lock2;
struct sharedmem main_mem;

void initmem(struct sharedmem *my_mem)
{
    initlock(&my_mem->lock, "shared mem");
    int i = 0;
    for (i = 0; i < PAGE_COUNT; i++)
        main_mem.pages[i].ref_count = 0;
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

int sys_open_sharedmem(void)
{
    int id;
    char **res;
    if ((argint(0, &id)) < 0 || (argptr(1, (char**)(&res), 4)) < 0)
        return 0;
    struct proc *proc = myproc();
    pde_t *pgdir = proc->pgdir;
    // uint shm = proc->shm;

    if (main_mem.pages[id].ref_count == 0)
    {
        *res = kalloc();

        memset(*res, 0, PGSIZE);
        mappages(pgdir, *res, PGSIZE, V2P(*res), PTE_W | PTE_U);
        main_mem.pages[id].frame = *res;
        main_mem.pages[id].ref_count++;
        // main_mem.pages[id].perm_info.mode = folan??;
        main_mem.pages[id].frame = (void*) *res; 
    }
    else
    {
        mappages(pgdir, *res, PGSIZE, V2P(main_mem.pages[id].frame), PTE_W | PTE_U);
        main_mem.pages[id].ref_count++;
        *res =(char*) main_mem.pages[id].frame;
        // proc->shm = shm;
        
    }
    return 0;    
}

int sys_close_sharedmem(void)
{
    int id;
    if ((argint(0, &id)) < 0)
        return -1;
    return 0;
}
