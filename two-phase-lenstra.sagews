︠0ce85634-01d7-4362-8ff4-f237b1fd2241s︠
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

def doubling(P,E):
    try:
        return P,E,2*P
    except ZeroDivisionError:
        P,E = EC_Gen(G,N)
        return P,E,0

def Lenstra(E,P,m,m1):
    Q = 0
    while(Q == 0):
        P,E,Q = doubling(P,E)
    primes = prime_range(m)
    for i in xrange(1,len(primes)):
        exponent = i**exp(primes[i],m1)
        for j in range(exponent):
            v = G(Q[0] - P[0])
            nwd = gcd(v,N)
            if (nwd == 1 or nwd == n):
                Q = Q + P
            else:
                return nwd,Q
    return -1,Q

def f(Qs):
    l = len(Qs)
    g = Integers().random_element(0,2)
    if (g == 1):
        try:
            Q = 2*Qs[l-1]
        except ZeroDivisionError:
            Q = Qs[l-1] + Qs[0]
    else:
        try:
            Q = 2*Qs[l-1] + Qs[0]
        except ZeroDivisionError:
            Q = Qs[l-1] + Qs[0]
    return Q

def birthday(Q,G,N):
    Qs = []
    Qs.append(Q)
    l = 0
    bdayFlag = True
    while (bdayFlag):
        X = f(Qs)
        Qs.append(X)
        l = l + 1
        if (Qs.count(Qs[l]) == 2):
            bdayFlag = False
    d = 0
    for i in range (l):
        for j in range (i+1,l+1):
            if (Qs[i][1] - Qs[j][1] == 0):
                d = d * N
            else:
                d = d * (Qs[i][1] - Qs[j][1])
    nwd = gcd(N,d)
    return nwd



N = 997*991*983
G = Integers(N)
m = m1 = 30

P,E = EC_Gen(G,N)
factor,Q = Lenstra(E,P,m,m1)

if (factor != -1):
    print "Lenstra:"
    print N,"is divisible by",factor
    print "Result is", N/int(factor)
else:
    print "Lenstra is dead"
    factor = birthday(Q,G,N)
    print "Birthday paradox:"
    print N,"is divisible by",factor
    print "Result is", N/int(factor)
︡2697ad7f-7e25-4724-869d-ba45bead9942︡{"stdout":"Lenstra is dead\nBirthday paradox:"}︡{"stdout":"\n971230541 is divisible by 0\nResult is"}︡{"stderr":"Error in lines 77-86\n"}︡{"stderr":"Traceback (most recent call last):\n  File \"/cocalc/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 1188, in execute\n    flags=compile_flags) in namespace, locals\n  File \"\", line 10, in <module>\n  File \"sage/rings/integer.pyx\", line 1955, in sage.rings.integer.Integer.__div__ (build/cythonized/sage/rings/integer.c:13460)\n    return coercion_model.bin_op(left, right, operator.truediv)\n  File \"sage/structure/coerce.pyx\", line 1166, in sage.structure.coerce.CoercionModel.bin_op (build/cythonized/sage/structure/coerce.c:10074)\n    return PyObject_CallObject(op, xy)\n  File \"sage/structure/element.pyx\", line 1718, in sage.structure.element.Element.__truediv__ (build/cythonized/sage/structure/element.c:12784)\n    return (<Element>left)._div_(right)\n  File \"sage/rings/integer.pyx\", line 1969, in sage.rings.integer.Integer._div_ (build/cythonized/sage/rings/integer.c:13577)\n    raise ZeroDivisionError(\"rational division by zero\")\nZeroDivisionError: rational division by zero\n"}︡{"done":true}︡









