// Proposition 6.3: normalized ramification and the genus-65 resolvent.
// Exact LMFDB j-map input: see LMFDB_inputs.md and ramification.md.
// Standalone Magma. The separate elliptic_targets.m supplies the rank bound.

SetSeed(20260920);
Q := Rationals();
P<t> := PolynomialRing(Q);
j5 := 4*(4*t-1)^3*(4*t^2+3*t+9);
assert j5-1728 eq 4*(t-1)*(16*t^2+8*t+21)^2;
assert Derivative(j5) eq 20*(4*t-1)^2*(16*t^2+8*t+21);
// Primary map record: coordinates x^5*(x-4y)^3*(9x^2+3xy+4y^2),x^10,
// leading coefficients -4,1. Set x=1,y=t, so t=y/x.
assert j5 eq -4*(1-4*t)^3*(9+3*t+4*t^2);
Partition := function(f)
    return Sort(&cat[[pair[2] : i in [1..Degree(pair[1])]]
                     : pair in Factorization(f)]);
end function;
p0 := Partition(j5); p1728 := Partition(j5-1728); pinfty := [Degree(j5)];
assert p0 eq [1,1,3] and p1728 eq [1,2,2] and pinfty eq [5];
print "J5", j5;
print "PARTITIONS_OVER_0_1728_INFINITY", p0, p1728, pinfty;
F<j> := RationalFunctionField(Q);
PF<z> := PolynomialRing(F);
disc := Discriminant(4*(4*z-1)^3*(4*z^2+3*z+9)-j);
assert disc eq 2^40*5^5*j^2*(j-1728)^2;
assert disc/5 eq (2^20*5^2*j*(j-1728))^2;
print "QUINTIC_DISCRIMINANT", disc;
print "DISCRIMINANT_SQUARECLASS", 5;

// Independently compute the base ramification indices from the target
// generators, not from the genus printed by group_theory_40.m.
SL := SL(2,Integers(40)); A := GL(2,Integers(40));
gg := [[7,16,30,37], [17,16,0,37], [23,20,4,39],
       [25,4,34,11], [25,12,8,25]];
G := sub<A | [A!v : v in gg]>;
act, perm, ker := CosetAction(SL,G meet SL);
Lengths := function(p)
    return Sort(&cat[[u[1] : i in [1..u[2]]] : u in CycleStructure(p)]);
end function;
base0 := Lengths(act(SL![0,-1,1,1]));
base1728 := Lengths(act(SL![0,-1,1,0]));
widths := Lengths(act(SL![1,1,0,1]));
assert base0 eq [3 : i in [1..32]];
assert base1728 eq [2 : i in [1..48]];
assert widths eq [4 : i in [1..8]] cat [8 : i in [1..8]];
NormalizePartition := function(part,e)
    return Sort(&cat[[r div GCD(r,e) : i in [1..GCD(r,e)]] : r in part]);
end function;
contributions := [Integers()|];
for e in base0 do
    part := NormalizePartition(p0,e);
    assert part eq [1,1,1,1,1]; Append(~contributions,5-#part);
end for;
for e in base1728 do
    part := NormalizePartition(p1728,e);
    assert part eq [1,1,1,1,1]; Append(~contributions,5-#part);
end for;
for e in widths do
    part := NormalizePartition(pinfty,e);
    assert part eq [5]; Append(~contributions,5-#part);
end for;
total := &+contributions;
assert total eq 64 and forall{c : c in contributions | IsEven(c)};
gsource := 1 + total div 2;
assert gsource eq 33;
print "BASE_INDICES_OVER_0_1728_INFINITY", base0,base1728,widths;
print "NORMALIZED_DIFFERENT_DEGREE", total;
print "ODD_DISCRIMINANT_SUPPORT_EMPTY", true;
print "NORMALIZED_SOURCE_GENUS", gsource;

// Construct the actual action on two-element subsets of the five letters.
subsets := [{i,k} : i,k in [1..5] | i lt k];
assert #subsets eq 10;
OnSubsets := function(p)
    return Sym(10)![Index(subsets,{i^p : i in b}) : b in subsets];
end function;
ASub := sub<Sym(10) | [OnSubsets(p) : p in Generators(Alt(5))]>;
SSub := sub<Sym(10) | [OnSubsets(p) : p in Generators(Sym(5))]>;
assert IsTransitive(ASub) and #ASub eq 60 and #SSub eq 120;
cycle5 := Sym(5)!(1,2,3,4,5);
respart := Lengths(OnSubsets(cycle5));
assert respart eq [5,5];
rescontrib := [10-#NormalizePartition(respart,e) : e in widths];
assert rescontrib eq [8 : i in [1..16]];
gres := 1 + (&+rescontrib) div 2;
assert gres eq 65;
print "TWO_SUBSET_FIVE_CYCLE_PARTITION", respart;
print "RESOLVENT_GEOMETRICALLY_CONNECTED", IsTransitive(ASub);
print "RESOLVENT_DIFFERENT_DEGREE", &+rescontrib;
print "RESOLVENT_GENUS", gres;

// Positive algebraic rank for an isogeny-class representative. The modular
// target's Jacobian link to that class is a separately attributed input.
E := EllipticCurve([Q|0,0,0,100,0]); point := E![5,25,1];
double := 2*point;
assert double eq E![9/4,-123/8,1];
assert Denominator(double[1]) ne 1;
print "ISOGENY_CLASS_REPRESENTATIVE", aInvariants(E);
print "RATIONAL_POINT", point;
print "DOUBLE_POINT", double;
print "NONTORSION_BY_LUTZ_NAGELL", true;
print "ALL_RAMIFICATION_CHECKS_PASSED";
quit;
