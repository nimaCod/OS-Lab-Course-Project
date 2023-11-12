#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    if (argc != 3)
    {
        printf(2, "use : test_copy src dest\n");
        exit();
    }

    if (copy_file(argv[1], argv[2]) < 0)
        printf(1, "copy failed!\n");

    exit();
}