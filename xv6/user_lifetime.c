#include "types.h"
#include "user.h"

int main(void)
{
    int pid;
    pid=fork();

    if(pid==0){
        //child process
        printf(2,"Child lifetime before sleep is: %d\n",lifetime());
        sleep(1000);// sleep for 10 seconds
        printf(2,"Child lifetime after sleep is: %d\n",lifetime());

    } else{
        wait(); // after child process finished
        printf(2,"Parent lifetime is: %d\n",lifetime());
    }


    exit();
}
