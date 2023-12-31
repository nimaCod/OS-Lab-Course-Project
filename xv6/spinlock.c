// Mutual exclusion spin locks.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
  lk->locked = 0;
  lk->cpu = 0;
}

void p_initlock(struct prioritylock *lk, char *name)
{
  initlock(&(lk->lock), name);
  initlock(&(lk->queue_lock), name);
  lk->head = 0;
}

// Acquire the lock.
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if (holding(lk))
    panic("acquire\n");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}

void print_queue2(struct queue *lock)
{
  struct queue *temp = lock;
  for (int i = 0; temp != 0; i++)
  {
    cprintf("at index %d proccess %d exist!\n", i, temp->pid);
    temp = temp->next;
  }
}

void add_queue(struct queue **head, int pid)
{
  cprintf("1\n");
  struct queue *res = (struct queue *)kalloc();
  cprintf("2\n");
  res->pid = pid;
  res->next = 0;
  cprintf("2.5\n");
  if (*head == 0)
  {
    *head = res;
    cprintf("3\n");
  }
  else
  {
    struct queue *temp = *head;
    cprintf("4\n");
    if (temp->pid < res->pid)
    {
      cprintf("5\n");
      res->next = temp;
      *head = res;
    }
    else
    {
      cprintf("6\n");
      while (temp->next != 0)
        if (temp->next->pid > res->pid)
          temp = temp->next;
        else
          break;
      res->next = temp->next;
      temp->next = res;
    }
  }
  // print_queue2(*head);
}

void rm_queue(struct queue **head, int pid)
{
  if (*head == 0)
    panic("queue null\n");
  else
  {
    struct queue *temp = *head;
    if (temp->pid == pid)
    {
      *head = temp->next;
      kfree((char *)temp);
    }
    else
    {
      while (temp->next != 0)
        if (temp->next->pid != pid)
          temp = temp->next;
        else
        {
          struct queue *temp2 = temp->next;
          temp->next = temp->next->next;
          kfree((char *)temp2);
          return;
        }
      panic("not found in queu!\n");
    }
  }
}

void prior_acquire(struct prioritylock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if (holding(&lk->lock))
    panic("acquire\n");
  // add it to queue
  acquire(&lk->queue_lock);
  int pid = myproc()->pid;
  add_queue(&lk->head, pid);
  release(&lk->queue_lock);

  while (1)
  {
    acquire(&lk->queue_lock);
    // The xchg is atomic.
    if (lk->head->pid == pid && xchg(&lk->lock.locked, 1) == 0)
    {
      rm_queue(&lk->head, pid);
      release(&lk->queue_lock);
      break;
    }
    release(&lk->queue_lock);
  }

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->lock.cpu = mycpu();
  getcallerpcs(&lk->lock, lk->lock.pcs);
}

// Release the lock.
void
release(struct spinlock *lk)
{
  if (!holding(lk))
    panic("release\n");

  lk->pcs[0] = 0;
  lk->cpu = 0;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
}

void p_release(struct prioritylock *lk)
{
  release(&lk->lock);
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  int r;
  pushcli();
  r = lock->locked && lock->cpu == mycpu();
  popcli();
  return r;
}


// Pushcli/popcli are like cli/sti except that they are matched:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
}

void
popcli(void)
{
  if (readeflags() & FL_IF)
    panic("popcli - interruptible\n");
  if (--mycpu()->ncli < 0)
    panic("popcli\n");
  if (mycpu()->ncli == 0 && mycpu()->intena)
    sti();
}

