#include "types.h"
#include "user.h"

int main(void)
{
    int pid, i;

    // Fork three child processes
    for (i = 0; i < 3; i++)
    {
        pid = fork();

        if (pid < 0)
        {
            printf(2, "Fork failed.\n");
            exit();
        }
        else if (pid == 0)
        {
            // Child process

            if (i == 2)
            {
                int pid2 = fork();
                if (pid2 == 0)
                {
                    // grand son fork
                    int uncle_count = get_uncle_count();
                    printf(1, "Child process %d: Uncle count = %d\n", getpid(), uncle_count);
                }
            }

            exit();
        }
    }

    // Wait for all child processes to complete
    for (i = 0; i < 3; i++)
    {
        wait();
    }

    exit();
}
