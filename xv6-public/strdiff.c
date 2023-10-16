#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    if (argc != 3)
    {
        printf(2, "not good args : %d!\n", argc);
        exit();
    }
    int fd = open("strdiff_result.txt", O_CREATE | O_WRONLY);
    if (fd < 0)
    {
        printf(2, "error: create backup file failed\n");
        exit();
    }
    uchar res[15];
    uchar index = 0;
    while (argv[1][index] != 0 && argv[2][index] != 0)
    {
        argv[1][index] = argv[1][index] >= 'a' ? argv[1][index] - ('a' - 'A') : argv[1][index];
        argv[2][index] = argv[2][index] >= 'a' ? argv[2][index] - ('a' - 'A') : argv[2][index];
        res[index] = (argv[1][index] < argv[2][index]) + '0';
        index++;
    }
    while (argv[1][index] != 0)
    {
        res[index] = '0';
        index++;
    }
    while (argv[2][index] != 0)
    {
        res[index] = '1';
        index++;
    }
    int size = index * sizeof(uchar);
    if (write(fd, res, size) != size)
    {
        printf(2, "error: write to backup file failed\n");
        exit();
    }
    close(fd);
    exit();
}