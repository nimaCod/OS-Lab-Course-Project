#include "types.h"
#include "user.h"

int main() {
    uint pid = getpid();
    change_queue(pid,1);
    ps();
    exit();
}
