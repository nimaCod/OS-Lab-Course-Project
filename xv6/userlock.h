

struct uspinlock {
    unsigned int locked;
};

void uacquire(struct uspinlock *lock);
void urelease(struct uspinlock *lock);
