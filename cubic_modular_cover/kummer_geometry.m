// Proposition 6.2: degree, normalized ramification and genus of the Kummer cover.
// The rational function h is displayed below; no external input is needed.
// Every divisor and place belongs to a function field, hence to its smooth
// projective normalization. The affine Kummer equation is only a chart.
SetSeed(20260920);
v1,v2,v3 := GetVersion(); print "Magma version",<v1,v2,v3>;
t0 := Cputime();
Q := Rationals(); Qx<x> := FunctionField(Q);
PY<Y> := PolynomialRing(Qx);
K<y> := FunctionField(Y^2-x^3-8); xE := K!x;
assert Genus(K) eq 1 and DegreeOfExactConstantField(K) eq 1;
h := (xE+2)*(xE^2+4*xE+16)/(xE*(xE-4)*(xE^2-2*xE+4));
assert (xE+2)*(xE^2-2*xE+4) eq y^2;
assert (xE-4)*(xE^2+4*xE+16) eq y^2-72;

function UniqueZero(f)
 D := Divisor(f); S,V := Support(D);
 zeros := [S[i] : i in [1..#S] | V[i] gt 0];
 assert #zeros eq 1;
 return zeros[1];
end function;
P2 := UniqueZero(xE+2);
Dplus := UniqueZero(xE^2+4*xE+16);
D0 := UniqueZero(xE); D4 := UniqueZero(xE-4);
Dminus := UniqueZero(xE^2-2*xE+4);
S,V := Support(Divisor(xE));
poles := [S[i] : i in [1..#S] | V[i] lt 0];
assert #poles eq 1;
O := poles[1];
places := [O,P2,D0,D4,Dminus,Dplus];
degrees := [Degree(p) : p in places];
assert degrees eq [1,1,2,2,2,4];
Dh := Divisor(h);
assert Dh eq 2*O+2*P2-D0-D4-2*Dminus+Dplus;
assert Degree(Dh) eq 0;
assert Set(Support(Dh)) eq Set(places);
valuations := [Valuation(Dh,p) : p in places];
assert valuations eq [2,2,-1,-1,-2,1];
assert &and[GCD(v,3) eq 1 : v in valuations];
assert Valuation(y,Dminus) eq 1;
assert Valuation(xE^2-2*xE+4,Dminus) eq 2;
print "Closed-place order: O,(-2,0),D0,D4,Dminus,Dplus";
print "Closed degrees",degrees;
print "Valuations of h",valuations;
print "Degree of div(h)",Degree(Dh);
geometricSupport := &+degrees;
assert geometricSupport eq 12;
print "Geometric support size",geometricSupport;
// v_O(2h)=2 remains 2 under extension of constants. Thus 2h is not a cube
// even over Qbar(E), proving geometric integrality and degree exactly three.
assert Degree(O) eq 1 and Valuation(2*h,O) eq 2;
PT<T> := PolynomialRing(K);
f := T^3-2*h;
assert IsIrreducible(f);
L<w> := ext<K | f>;
assert Degree(L,K) eq 3 and w^3 eq L!(2*h);
assert (L!y)^2 eq (L!xE)^3+8;
print "Degree of Q(C)/Q(E)",Degree(L,K);
print "The Q-defined map is (x,y,w) -> (x,y).";
// A nonconstant inclusion of function fields of smooth projective curves
// extends uniquely to a finite morphism; it has no unresolved base points.
OL := MaximalOrderFinite(L); OInf := MaximalOrderInfinite(L);
D := 0*Dh;
for p in places do
 dtype := DecompositionType(L,p);
 assert dtype eq [<1,3>]; // relative (residue degree,ramification index)
 assert #Decomposition(L,p) eq 1;
 coefficient := &+[z[1]*(z[2]-1) : z in dtype];
 assert coefficient eq 2;
 D +:= coefficient*p;
 print "Branch closed degree, valuation, relative decomposition",Degree(p),Valuation(h,p),dtype;
end for;
// Outside div(h), the radicand and the polynomial discriminant -27(2h)^2
// are horizontal units. The cubic algebra is etale, so there is no further
// geometric ramification. D is the normalized trace-discriminant divisor.
Br := &+places;
assert D eq 2*Br;
assert Degree(D) eq 24;
odd := [p : p in places | IsOdd(Valuation(D,p))];
assert #odd eq 0;
gRH := 1+(Degree(L,K)*(2*Genus(K)-2)+Degree(D)) div 2;
g := Genus(L);
assert g eq gRH and g eq 13;
print "Trace-discriminant degree",Degree(D);
print "Odd support size",#odd;
print "Riemann-Hurwitz genus and independent function-field genus",gRH,g;
print "All normalized Kummer geometry assertions passed.";
print "CPU seconds",Cputime(t0);
