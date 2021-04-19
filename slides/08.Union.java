class AUB {
    Boolean isA() { throw ...; }
    op0() { throw ...; }
    opA() { throw ...; }
    opB() { throw ...; }
}

class A extends AUB {
    isA() { return true; }
    op0() { ... };
    opA() { ... };
}

class B extends AUB {
    isA() { return false; }
    op0() { ... };
    opB() { ... };
}

----------------------

interface AUB {
    Boolean isA();
    op0();
    opA(int x);
    opB(float y);
}

class A implements AUB {
    isA() { return true; }
    op0() { ... };
    opA(int x) { ... };
    opB(float y ) { throw ... };
}

class B implements AUB {
    isA() { return false; }
    op0() { ... };
    opB(float y) { ... };
    opA(int x) { throw ... };
}

-------------------------

What is the problem with the interface AUB?   

f(AUB u) {
    u.op0();
    u.opA(3);  // may trigger exception
}

f(AUB u) {
    if (u.isA()) {
	u.opB(1.2);  // exception
    }
}

f(AUB u) {
    u.op0();
    if (u.isA()) { u.opA(3); }
    else { u.opB(1.2); }
}

--------------------

interface AUB {
    op0();
    AI getA();
    BI getB();
}

interface AI extends AUB {
    opA();
}

interface BI extends AUB {
    opB();
}

class A implements AI {
    AI getA() { return this; }
    BI getB() { return null; }
    op0() { ... };
    opA() { ... };
}

class B implements BI {
    AI getA() { return null; }
    BI getB() { return this; }
    op0() { ... };
    opB() { ... };
}

f(AUB u) {
    AI a;
    BI b;
    u.op0();
    if ((a = u.getA()) != null) {
	a.opA();
    } else if ((b = u.getB()) != null) {
	b.opB();
    } else { throw ...; } // impossible case
}

