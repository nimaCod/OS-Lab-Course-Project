#include "types.h"
#include "user.h"
#define PROCS_NUM 1

int main()
{
    uint child1, child2, child3, grand_child;

    child1 = fork();
    if (child1 == 0)
    {
        // Child 1 process
        sleep(1000); // wait
    }
    else
    { // parent proc
        child2 = fork();
        if (child2 == 0)
        {
            // Child 2 process
            sleep(10000);
        }
        else
        {
            child3 = fork();
            if (child3 == 0)
            {
                // Child 3 process
                // printf(2, "Parent: PID=%d\n", getpid());

                grand_child = fork();

                if (grand_child == 0)
                {
                    long int x=0;
                    for (long i = 0; i < 1000000000; i++)
                    {
                        for (long j = 0; j < 1000000000; j++)
                        {
                            for (long k = 0; k < 1000000000; k++)
                            {
                                x += i * j * k;
                            }
                        }
                    }
                    // Grand child 1 process
                } 
                wait();
            }
            else
            {
                change_queue(child3, 3);
            }
        }
    }
    wait();
    wait();
    wait();
    exit();
}