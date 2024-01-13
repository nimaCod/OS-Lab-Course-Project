#include "spinlock.h"

struct page
{
    int id;
    int ref_count;
    void *frame;
};

struct sharedmem
{
    struct spinlock lock;
    struct page *pages;
    int page_count;
};