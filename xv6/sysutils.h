#include "spinlock.h"

#define PAGE_COUNT 10 

struct page
{
    int id;
    int ref_count;
    void *frame;

};

struct sharedmem
{
    struct spinlock lock;
    struct page pages[PAGE_COUNT];
};


