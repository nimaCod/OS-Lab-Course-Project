#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

void do_temp()
{
    int sum = 0;
    for (int i = 0; i < 1000000000000; i++)
        sum += i;
}

int main(int argc, char *argv[])
{
    if (argc != 1)
    {
        printf(2, "not good args : %d!\n", argc);
        exit();
    }

    if (fork() == 0)
    {
        // printf(2, "1\n");
        aq();
    }
    else
    {
        if (fork() == 0)
        {
            // printf(2, "2\n");
            aq();
        }
        else
        {
            if (fork() == 0)
            {
                // printf(2, "3\n");
                aq();
            }
            else
            {
                wait();
            }
            wait();
        }
        wait();
    }

    exit();
}