#include "types.h"
#include "user.h"

int main() {
    uint child1, child2, child3, grand_child;

    child1 = fork();
    if (child1 == 0) {
        // Child 1 process
        printf(2, "Uncle 1: PID=%d\n", getpid());
        sleep(100); // wait
    } else { // parent proc 
        child2 = fork();
        if (child2 == 0){
            // Child 2 process
            printf(2, "Uncle 2: PID=%d\n", getpid());
            sleep(100);
        } else {
            child3 = fork();
            if  (child3 == 0)
            {
                // Child 3 process
                printf(2, "Parent: PID=%d\n", getpid());

                grand_child = fork();
                if (grand_child == 0)
                {
                    // Grand child 1 process
                    printf(2, "Grand Child: PID=%d\n", getpid());

                    // Call the custom system call to get information about the uncle process
                    int uncle_pid = get_uncle_count();
                    if (uncle_pid > 0)
                    {
                        printf(2, "Number of uncles:%d\n", uncle_pid);
                    }
                }
                wait();
            }
        }
    }
    wait();
    wait();
    wait();
    exit();
}
