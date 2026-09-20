// Selected genus and resolvent checks for Proposition 6.4 and Remark 6.5.
// Exact computations in Magma; see README.md for the inputs and scope.
// A finite list of checks does not prove the manuscript's general proposition.
// Genus is computed from exact fibre multiplicities and normalized inertia,
// then compared with the formula. Boundary cases are also checked directly
// using Magma's function-field genus and exact constant-field degree.

SetSeed(20260920);

function PermutationIndex(g, d)
    return d-#Orbits(sub<Sym(d) | g>);
end function;

function NormalizePartition(partition, e)
    normalized := [];
    for r in partition do
        d := GCD(r,e);
        normalized cat:= [r div d : j in [1..d]];
    end for;
    return normalized;
end function;

function PartitionIndex(partition)
    return &+partition-#partition;
end function;

function TwoSubsetAction(g,n)
    pairs := Setseq(Subsets({1..n},2));
    images := [Index(pairs,{i^g : i in A}) : A in pairs];
    return Sym(#pairs)!images;
end function;

function QuarticBlockAction(g)
    blocks := [{ {1,2},{3,4} }, { {1,3},{2,4} }, { {1,4},{2,3} }];
    images := [Index(blocks,{{i^g : i in A} : A in B}) : B in blocks];
    return Sym(3)!images;
end function;

// An exact integer test, with no floating-point logarithms: a collision
// requires 2^m=(n-1)^3. These are all positive integer possibilities.
collision_pairs := [];
for n in [3,4,5] do
    a := (n-1)^3;
    m := 0;
    while IsEven(a) do a div:= 2; m +:= 1; end while;
    if a eq 1 and m gt 0 then Append(~collision_pairs,<n,m>); end if;
end for;
assert collision_pairs eq [<3,3>,<5,6>];
printf "RESULT all_possible_collision_pairs %o\n", collision_pairs;

S4 := Sym(4);
S5 := Sym(5);
tau4 := S4!(1,2);
cycle4 := S4!(1,2,3,4);
tau5 := S5!(1,2);
cycle5 := S5!(1,2,3,4,5);
assert PermutationIndex(QuarticBlockAction(tau4),3) eq 1;
assert PermutationIndex(TwoSubsetAction(tau5,5),10) eq 3;
assert PermutationIndex(TwoSubsetAction(cycle5,5),10) eq 8;
assert IsTransitive(sub<Sym(3) | QuarticBlockAction(tau4),QuarticBlockAction(cycle4)>);
assert IsTransitive(sub<Sym(10) | TwoSubsetAction(tau5,5),TwoSubsetAction(cycle5,5)>);
printf "RESULT quintic_two_subset_transposition_cycles %o\n", CycleStructure(TwoSubsetAction(tau5,5));
printf "RESULT quintic_two_subset_five_cycle_cycles %o\n", CycleStructure(TwoSubsetAction(cycle5,5));

pairs := [];
for n in [3,4,5] do
    for m in [n+2..n+6] do Append(~pairs,<n,m>); end for;
end for;
pairs cat:= [<3,4>,<4,5>,<5,6>];
boundary_expected := AssociativeArray();
boundary_expected[<3,4>] := 10;
boundary_expected[<4,5>] := 17;
boundary_expected[<5,6>] := 24;

for pair in pairs do
    n,m := Explode(pair);
    K<zeta> := CyclotomicField(n-1);
    P<z> := PolynomialRing(K);
    f := z^n-n*z;
    critical := Roots(Derivative(f));
    assert #critical eq n-1 and &and[r[2] eq 1 : r in critical];
    values := [Evaluate(f,r[1]) : r in critical];
    assert #Seqset(values) eq n-1 and 0 notin values;
    assert &and[Evaluate(f,r[1]) eq -(n-1)*r[1] : r in critical];
    different_finite := 0;
    collision_count := 0;
    for c in values do
        fact := Factorization(f-c);
        partition := &cat[[r[2] : j in [1..Degree(r[1])]] : r in fact];
        assert &+partition eq n;
        assert PartitionIndex(partition) eq 1;
        // Roots shared with x^3-2 have y=0 and E -> P1_t index 2.
        // Every other root has two points on E, both of index 1.
        polynomial := z^m-c;
        assert GCD(polynomial,Derivative(polynomial)) eq 1;
        k := Degree(GCD(polynomial,z^3-2));
        ordinary_points := 2*(m-k);
        p1 := NormalizePartition(partition,1);
        p2 := NormalizePartition(partition,2);
        contribution := ordinary_points*PartitionIndex(p1)+k*PartitionIndex(p2);
        different_finite +:= contribution;
        collision_count +:= k;
        printf "FINITE n=%o m=%o critical_value=%o fibre=%o ordinary_points=%o double_base_points=%o normalized_at_double=%o contribution=%o\n",
            n,m,c,partition,ordinary_points,k,p2,contribution;
        if n eq 5 and m eq 6 and c eq 4 then
            assert k eq 3 and contribution eq 6;
        end if;
    end for;
    // The unique source point at infinity of the polynomial map has
    // index n, and x^m has a pole of order 2m at the elliptic origin.
    infinity_partition := NormalizePartition([n],2*m);
    different_infinity := PartitionIndex(infinity_partition);
    cycle := Sym(n)!([2..n] cat [1]);
    assert different_infinity eq PermutationIndex(cycle^(2*m),n);
    total := different_finite+different_infinity;
    assert IsEven(total);
    genus := 1+total div 2;
    printf "RESULT n=%o m=%o collision_x_roots=%o finite_different=%o infinity_partition=%o infinity_different=%o normalized_genus=%o\n",
        n,m,collision_count,different_finite,infinity_partition,different_infinity,genus;
    if pair in collision_pairs then
        assert pair eq <5,6>;
        assert collision_count eq 3;
        // Coprimality at infinity is a geometric irreducibility certificate:
        // the Newton polygon has slope 2m/n with denominator n.
        assert GCD(n,2*m) eq 1;
    else
        assert collision_count eq 0;
        expected := 1+m*(n-1)+(n-GCD(n,2*m)) div 2;
        assert genus eq expected;
    end if;
    if IsDefined(boundary_expected,pair) then
        assert genus eq boundary_expected[pair];
    end if;

    if n eq 4 and collision_count eq 0 then
        finite_index := PermutationIndex(QuarticBlockAction(tau4),3);
        infinity_index := PermutationIndex(QuarticBlockAction(cycle4^(2*m)),3);
        resolvent_genus := 1+((#values)*2*m*finite_index+infinity_index) div 2;
        assert infinity_index eq 0 and resolvent_genus eq 3*m+1;
        printf "RESULT quartic_resolvent m=%o infinity_index=%o genus=%o\n",m,infinity_index,resolvent_genus;
        // This discriminant is used to check the cubic block resolvent
        // equation. It is not substituted for the normalized trace divisor.
        PT<t> := PolynomialRing(Rationals());
        PU<u> := PolynomialRing(PT);
        assert Discriminant(u^3+4*t^m*u-16) eq -256*(t^(3*m)+27);
    end if;
    if n eq 5 and collision_count eq 0 then
        finite_index := PermutationIndex(TwoSubsetAction(tau5,5),10);
        infinity_index := PermutationIndex(TwoSubsetAction(cycle5^(2*m),5),10);
        resolvent_genus := 1+((#values)*2*m*finite_index+infinity_index) div 2;
        expected := m mod 5 eq 0 select 12*m+1 else 12*m+5;
        assert resolvent_genus eq expected;
        printf "RESULT quintic_resolvent m=%o infinity_index=%o genus=%o\n",m,infinity_index,resolvent_genus;
    end if;
end for;

// Derive the cubic block-resolvent equation by a polynomial identity in
// four formal roots, independently of its stated discriminant or genus.
M<a,b,c,d,U> := PolynomialRing(Rationals(),5);
e1 := a+b+c+d;
e2 := a*b+a*c+a*d+b*c+b*d+c*d;
e3 := a*b*c+a*b*d+a*c*d+b*c*d;
e4 := a*b*c*d;
block_product := (U-a*b-c*d)*(U-a*c-b*d)*(U-a*d-b*c);
assert block_product eq U^3-e2*U^2+(e1*e3-4*e4)*U-e3^2-e1^2*e4+4*e2*e4;
// For Z^4-4Z-t: e1=e2=0, e3=4, e4=-t.
print "CHECK quartic_block_resolvent_identity true";

// A second genus calculation on the actual function-field normalization.
// The constructor checks irreducibility over Q(E). Genus computes the exact
// constant-field degree too: value 1 certifies geometric connectedness.
Qx<x> := RationalFunctionField(Rationals());
PY<Y> := PolynomialRing(Qx);
EF<y> := FunctionField(Y^2-x^3+2);
for pair in [<3,4>,<4,5>,<5,6>] do
    n,m := Explode(pair);
    PZ<Z> := PolynomialRing(EF);
    CF<w> := FunctionField(Z^n-n*Z-(EF!x)^m);
    assert Degree(CF) eq n;
    g := Genus(CF);
    constant_degree := DegreeOfExactConstantField(CF);
    assert g eq boundary_expected[pair] and constant_degree eq 1;
    printf "FUNCTION_FIELD n=%o m=%o degree=%o genus=%o exact_constant_degree=%o\n",
        n,m,Degree(CF),g,constant_degree;
end for;
for m in [5,6] do
    PU<u> := PolynomialRing(EF);
    RF<v> := FunctionField(u^3+4*(EF!x)^m*u-16);
    g := Genus(RF);
    constant_degree := DegreeOfExactConstantField(RF);
    assert Degree(RF) eq 3 and g eq 3*m+1 and constant_degree eq 1;
    printf "FUNCTION_FIELD quartic_resolvent m=%o degree=%o genus=%o exact_constant_degree=%o\n",
        m,Degree(RF),g,constant_degree;
end for;
print "CHECK all_selected_uniform_family_instances true";
quit;
