def main(n):
    prime = [True for _ in range(n + 1)]
    prime[0], prime[1] = False, False
    p = 2
    while p * p <= n:
        if prime[p] == True:
            for i in range(p ** 2, n + 1, p):
                prime[i] = False
        p += 1
    # for p in numbers:
    #     if prime[p]:
    #         print (p,end=" ")
import timeit
print(timeit.repeat("main(1000)", "from __main__ import main", number=1000))