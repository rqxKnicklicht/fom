def main(n):
    return n/2 * n+1//2

def main2(n: int) -> None:
    return (n*n+1)/2

import timeit
print(timeit.timeit("main(1000000)", "from __main__ import main", number=1))