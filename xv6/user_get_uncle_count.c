#include "types.h"
#include "stat.h"
#include "user.h"
// We want Child 1 to execute first, then Child 2, and finally Parent.
int main()
{
    printf(2,"%d\n",get_uncle_count());
}
