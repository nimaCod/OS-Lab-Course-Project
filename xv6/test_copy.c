#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    if (argc == 4)
    {
        int fd = open(argv[1], O_CREATE | O_WRONLY);
        if (fd < 0)
            printf(2, "err\n");
        write(fd, argv[2], strlen(argv[2]));
        close(fd);
        exit();
    }
    if (argc != 3)
    {
        printf(2, "not good args : %d!\n", argc);
        exit();
    }

    if (copy_file(argv[1], argv[2]) == 0)
        printf(1, "copy successful!\n");
    else
        printf(1, "copy failed!\n");

    exit();
}