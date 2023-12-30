// Mutual exclusion lock.
struct spinlock
{
  uint locked; // Is the lock held?

  // For debugging:
  char *name;      // Name of lock.
  struct cpu *cpu; // The cpu holding the lock.
  uint pcs[10];    // The call stack (an array of program counters)
                   // that locked the lock.
};

struct queue
{
  struct queue *next;
  int pid;
};

struct prioritylock
{
  struct spinlock lock;
  struct spinlock queue_lock;
  struct queue *head;
};