def EC_Gen(G,N):
    flag = True
    while (flag):
        x = G.random_element()
        y = G.random_element()
        a = G.random_element()
        b = G(y**2 - x**3 - a*x)
        d = G(4*a^3 + 27*b^2)
        if (gcd(N,d) == 1):
            E = EllipticCurve(G,[a,b])
            P = E([x,y])
            flag = False
    return P,E

def exp(pi, m1):
    ei = floor(ln(m1)/ln(pi))
    return ei

def doubling(P):
    try:
        return True,2*P
    except ZeroDivisionError:
        return False,2*P[1]

def Lenstra(E,P,m,m1):
    doublingFlag = False
    while (not(doublingFlag)):
        doublingFlag,Q = doubling(P)
        if (not(doublingFlag)):
            nwd = gcd(2*P[1],N)
            if (nwd == 1 or nwd == N):
                P,E = EC_Gen(G,N)
            else:
                return nwd,0
    primes = prime_range(m)
    for i in xrange(1,len(primes)):
        exponent = i**exp(primes[i],m1)
        for j in range(exponent):
            v = G(Q[0] - P[0])
            nwd = gcd(v,N)
            if (nwd == 1 or nwd == N):
                Q = Q + P
            else:
                return nwd,Q
    return -1,Q

def f(Qs):
    length = len(Qs)
    fFlag,Q = doubling(Qs[length-1])
    if (fFlag):
        g = Integers().random_element(0,2)
        if (g == 0):
            v = G(Q[0] - Qs[0][0])
            nwd = gcd(v,N)
            if (nwd == 1 or nwd == N):
                Q = Q + Qs[0]
                return True,-1,Q
            else:
                return False,nwd,Q
        return True,-1,Q
    return False,gcd(2*Qs[length-1][1],N),Q

#TODO check groups
def birthday(Q,G,N):
    Qs = []
    Qs.append(Q)
    l = 0
    bdayFlag = True
    while (bdayFlag):
        fFlag,nwd,X = f(Qs)
        if (fFlag):
            Qs.append(X)
            l = l + 1
            if (Qs.count(Qs[l]) == 2):
                bdayFlag = False
        else:
            return nwd
    d = 0
    for i in range (l):
        for j in range (i+1,l+1):
            d = d * (Qs[i][1] - Qs[j][1])
    nwd = gcd(N,d)
    return nwd


N = 105019*105341*105607*105943
G = Integers(N)
m = m1 = 30

P,E = EC_Gen(G,N)
factor,Q = Lenstra(E,P,m,m1)

if (factor != -1):
    print "From Lenstra:"
else:
    factor = birthday(Q,G,N)
    print "From birthday paradox:"

print N,"is divisible by",factor,
if (factor.is_prime()):
    print "(is",
else:
    print "(isn't",
print "prime)"
print "Result is", N/int(factor)









