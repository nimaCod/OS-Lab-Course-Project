#include "types.h"
#include "user.h"
int main(int argc, char *argv[])    { 
    int num_forks = 5;
    int num_sleep= 2;
    for(int i =0;i<num_forks;i++){
        int pid = fork();
        if(pid == 0){
            for(int j = 0; j<num_sleep;j++){
                sleep(1);
            }
        }
        else{
            wait();
            if(i==num_forks-1)
                print_num_syscalls();

        }
    }
    exit();
}
