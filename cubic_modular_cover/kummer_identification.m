// Lemma 6.1: original j-map transport and the exact scalar-2 identity.
// Original LMFDB models and maps: see LMFDB_inputs.md (22 July 2026 extract).
// This checks the birational transport, factorization and exact scalar 2.
// Coordinates X,Y,Z,W below belong to the embedded genus-two model. W is
// not the cubic Kummer variable. Map 465 uses weights (1,3,1) on (a,v,z).
SetSeed(20260920);
v1,v2,v3 := GetVersion(); print "Magma version",<v1,v2,v3>;
t0 := Cputime();
Q := Rationals();
Qa<a> := FunctionField(Q);
Pv<V> := PolynomialRing(Qa);
fY := V^2+(a^3+1)*V+5*a^3+7;
assert IsIrreducible(fY);
KY<v> := FunctionField(fY);
aa := KY!a;
assert v^2+(aa^3+1)*v+5*aa^3+7 eq 0;
assert Genus(KY) eq 2;
d := v^2+v+7;
X := aa; Y := 27*aa^2/d; Z := -9*(v+2)*aa^2/d; W := KY!3;
relations := [
 X*Y*W-X*Z*W+W^3,
 X*Y*Z-X*Z^2+Z*W^2,
 X*Y^2-X*Y*Z+Y*W^2,
 X^2*Y-X^2*Z+X*W^2,
 Y^3-Z^3+6*X*Y*W+3*X*Z*W-3*W^3,
 6*X^2*Y+3*X^2*Z-Y^2*W-Y*Z*W-Z^2*W-3*X*W^2];
assert &and[r eq 0 : r in relations];
map465 := [X,-X^3+X*Z*W/3-5*W^3/27,W/3];
assert map465 eq [aa,v,KY!1];
// Original absolute j-map 463: the first coordinate has leading factor 27.
jNumerator := 81*X^4*W^4-54*X*Z^6*W+3*X*Z^3*W^4
 +9*Y^2*Z^6+57*Y^2*Z^3*W^3-Y^2*W^6
 +57*Y*Z^4*W^3-2*Y*Z*W^6+57*Z^5*W^3-3*Z^2*W^6;
jDenominator := W^4*(3*X*Z^3-Y^2*W^2-2*Y*Z*W^2-3*Z^2*W^2);
function J(u)
 return (u-9)^3*(u+3)^3/u^3;
end function;
assert jDenominator ne 0;
assert 27*jNumerator/jDenominator eq J(aa^3);
print "The six original embedded equations vanish after substitution.";
print "The original birational map recovers (a,v,1).";
print "The original j-map, including its factor 27, equals J(a^3).";

// Map 7 on the split Cartan: cancel x^12 and use t=x/y.
// The retained coordinate v is needed: Q(a^3,v) has degree two over Q(a^3).
t := -v-2;
jSplit := (t^4+216*t)^3/(t^3-27)^3;
assert aa^3 eq (t^2+3*t+9)/(t-3);
assert J(aa^3) eq jSplit;
print "The invariant field Q(a^3,v) has the stored split-Cartan j-map.";

Qx<x> := FunctionField(Q);
PY<Ye> := PolynomialRing(Qx);
KE<y> := FunctionField(Ye^2-x^3-8);
assert Genus(KE) eq 1 and DegreeOfExactConstantField(KE) eq 1;
s := x^3+8;
jE := (s+24)^3*(s^3+1800*s^2-25920*s+124416)^3 /
      (8*s^3*(s-72)^6*(s-8)^2);
// This is precisely saved map 10595 in z=1, including denominator factor 8.
assert KE!jE eq (y^2+24)^3*(y^6+1800*y^4-25920*y^2+124416)^3 /
                (8*y^6*(y^2-72)^6*(y^2-8)^2);
h := (x+2)*(x^2+4*x+16)/(x*(x-4)*(x^2-2*x+4));
U1 := -54*x^2*(x-4)^2*(x+2)/((x^2+4*x+16)^2*(x^2-2*x+4));
U2 := -27/U1;
q := -3*x*(x-4)/(x^2+4*x+16);
assert J(U1) eq jE and J(U2) eq jE;
assert U1 eq 2*h*q^3;
assert U1*U2 eq (-3)^3;
PU<U> := PolynomialRing(Qx);
eqU := (U-9)^3*(U+3)^3-jE*U^3;
fac := Factorization(eqU);
degrees := Sort([Degree(f[1]) : f in fac]);
assert degrees eq [1,1,2,2];
assert &and[f[2] eq 1 : f in fac];
assert #{f : f in fac | Degree(f[1]) eq 1 and Evaluate(f[1],U1) eq 0} eq 1;
assert #{f : f in fac | Degree(f[1]) eq 1 and Evaluate(f[1],U2) eq 0} eq 1;
assert U1 ne U2;
for f in fac do
 print "Factor and multiplicity",f;
 if Degree(f[1]) eq 2 then
  disc := Discriminant(f[1]);
  square,r := IsSquare(-disc/3);
  assert disc ne 0 and square and disc eq -3*r^2;
  print "Quadratic discriminant is -3 times this square",r;
 end if;
end for;
// Since Q is the exact constant field of KE, -3 is not a square there.
// Thus both quadratics remain irreducible over KE. We also factor there.
PE<UE> := PolynomialRing(KE);
facE := Factorization(PE!eqU);
assert Sort([Degree(f[1]) : f in facE]) eq [1,1,2,2];
assert &and[f[2] eq 1 : f in facE];
assert not IsSquare(KE!-3);
print "Factor degrees over Q(E)",Sort([Degree(f[1]) : f in facE]);
print "U1=2*h*q^3 and U1*U2=(-3)^3, exactly.";
print "Either possible modular U gives Q(E)(cube_root(2*h)).";
print "All original-map transport and scalar-2 assertions passed.";
print "CPU seconds",Cputime(t0);
