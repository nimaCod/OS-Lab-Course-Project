#include "types.h"
#include "stat.h"
#include "user.h"
#include "userlock.h"
#include "x86.h"

struct shm_cnt
{
    struct uspinlock lock;
    int cnt;
};

int main(int argc, char *argv[])
{
    if (fork())
    {
        if (fork())
        {
            struct shm_cnt *counter;
            open_sharedmem(1, (char **)&counter);
            uacquire(&(counter->lock));
            counter->cnt++;
            urelease(&(counter->lock));
            wait();
            close_sharedmem(1);
        }
        else
        {
            struct shm_cnt *counter;
            open_sharedmem(1, (char **)&counter);
            uacquire(&(counter->lock));
            counter->cnt++;
            urelease(&(counter->lock));
            close_sharedmem(1);
            exit();
            return 0;
        }
        wait();
        exit();
        return 0;
    }
    else
    {
        struct shm_cnt *counter;
        open_sharedmem(1, (char **)&counter);
        uacquire(&(counter->lock));
        counter->cnt++;
        urelease(&(counter->lock));
        close_sharedmem(1);
        exit();
        return 0;
    }
}