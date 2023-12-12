#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

#define MAX_STR 30

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        printf(2, "Invalid usage.\n Use %s [change_queue] [PID] [NEW_QUEUE] |\n set_bjf_for_process [PID] [RATIOS] |\n set_bjf_for_all [RATIOS] |\n ps.\n", argv[0]);
        exit();
    }

    change_queue(getpid(), 1);
    // float priority_ratio, arrival_time_ratio, executed_cycle_ratio, process_size_ratio;
    // priority_ratio = 0.1;
    // arrival_time_ratio = 0.1;
    // executed_cycle_ratio = 0.1;
    // process_size_ratio = 0.1;
    char *sys_call;
    sys_call = argv[1];
    if (strcmp(sys_call, "cq") == 0)
    {
        change_queue(atoi(argv[2]), atoi(argv[3]));
    }
    else if (strcmp(sys_call, "sbfp") == 0)
    {
        // set_bjf_for_proincludecess(atoi(argv[2]),priority_ratio , arrival_time_ratio ,executed_cycle_ratio , process_size_ratio);
        set_bjf_for_process(atoi(argv[2]), atoi(argv[3]), atoi(argv[4]), atoi(argv[5]), atoi(argv[6]));
    }
    else if (strcmp(sys_call, "sbfa") == 0)
    {
        // set_bjf_for_all(priority_ratio , arrival_time_ratio ,executed_cycle_ratio , process_size_ratio);
        set_bjf_for_all(atoi(argv[2]), atoi(argv[3]), atoi(argv[4]), atoi(argv[5]));
    }
    else if (strcmp(sys_call, "ps") == 0)
        ps();
    else
        printf(2, "Invalid usage.\n Use cq [PID] [NEW_QUEUE] |\n sbfp [PID] [RATIOS] |\n sbfa [RATIOS] |\n ps.>");
    exit();
}