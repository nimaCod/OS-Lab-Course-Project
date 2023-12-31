#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    if (argc != 1)
    {
        printf(2, "not good args : %d!\n", argc);
        exit();
    }

    fork();
    fork();
    aq();
    int sum = 0;
    for (int i = 0; i < 100000; i++)
        sum += i;
    rel();
    exit();
}