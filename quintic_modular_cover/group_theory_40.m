// Proposition 6.3: quintic group inclusion, monodromy and genus.
// LMFDB row-major generators retrieved 2026-09-20; see LMFDB_inputs.md.
// Standalone Magma: genera are computed from S/R/T coset actions.

SetSeed(20260920);
N := 40;
A := GL(2, Integers(N));
Sambient := SL(2, Integers(N));
hg := [[23,36,4,7], [25,24,38,35], [33,4,32,33],
       [39,12,26,21], [39,36,8,3]];
gg := [[7,16,30,37], [17,16,0,37], [23,20,4,39],
       [25,4,34,11], [25,12,8,25]];
H := sub<A | [A!v : v in hg]>;
G := sub<A | [A!v : v in gg]>;
H1 := H meet Sambient;
G1 := G meet Sambient;
minusI := A![-1,0,0,-1];
units := {a : a in [0..N-1] | GCD(a,N) eq 1};
print "COMMON_LEVEL", N;
print "SOURCE_GENERATORS", hg;
print "TARGET_GENERATORS", gg;
print "INCLUSION_CONJUGATOR", [1,0,0,1];
assert H subset G;
assert minusI in H and minusI in G;
assert {Integers()!Determinant(h) : h in H} eq units;
assert {Integers()!Determinant(g) : g in G} eq units;
assert #A eq 737280 and #Sambient eq 46080;
assert #G eq 7680 and #H eq 1536;
assert #G1 eq 480 and #H1 eq 96;
print "GL2_ORDER_SOURCE_TARGET", #H, #G;
print "SL2_ORDER_SOURCE_TARGET", #H1, #G1;
print "GL2_INDEX_SOURCE_TARGET", Index(A,H), Index(A,G);
print "SL2_INDEX_SOURCE_TARGET", Index(Sambient,H1), Index(Sambient,G1);
print "PROJECTIVE_SL2_ORDERS", #H1 div 2, #G1 div 2;
assert Index(G,H) eq 5 and Index(G1,H1) eq 5;
print "COARSE_GEOMETRIC_DEGREE", Index(G1,H1);
print "FULL_DETERMINANT_AND_MINUS_I", true;

// Determine exact GL2 and SL2 levels by testing full inverse images at
// every divisor of the common level. The target SL2 level is only 8.
Reduction := function(K,d)
    Ad := GL(2,Integers(d));
    return sub<Ad | [Ad![Integers()!x : x in Eltseq(k)]
                          : k in Generators(K)]>;
end function;
ExactLevel := function(K, special)
    ambient := special select Sambient else A;
    for d in Divisors(N) do
        if d eq 1 then
            imorder := 1; ambientorder := 1;
        else
            imorder := #Reduction(K,d);
            ambientorder := special select #SL(2,Integers(d))
                                    else #GL(2,Integers(d));
        end if;
        if #K eq imorder*(#ambient div ambientorder) then return d; end if;
    end for;
    error "No full inverse-image level found";
end function;
assert ExactLevel(H,false) eq 40 and ExactLevel(G,false) eq 40;
assert ExactLevel(H1,true) eq 40 and ExactLevel(G1,true) eq 8;
print "EXACT_GL2_LEVELS", ExactLevel(H,false), ExactLevel(G,false);
print "EXACT_SL2_LEVELS", ExactLevel(H1,true), ExactLevel(G1,true);

A5mat := GL(2,Integers(5));
Reduce5 := function(g)
    return A5mat![Integers()!x : x in Eltseq(g)];
end function;
H5 := sub<A5mat | [Reduce5(h) : h in Generators(H)]>;
G5 := sub<A5mat | [Reduce5(g) : g in Generators(G)]>;
H15 := sub<A5mat | [Reduce5(h) : h in Generators(H1)]>;
G15 := sub<A5mat | [Reduce5(g) : g in Generators(G1)]>;
assert G5 eq A5mat and #H5 eq 96;
assert G15 eq SL(2,Integers(5)) and #H15 eq 24;
inverseImage := {g : g in G | Reduce5(g) in H5};
assert inverseImage eq {h : h in H};
print "MOD5_ORDERS_G_H_GSL_HSL", #G5, #H5, #G15, #H15;
print "INVERSE_IMAGE_EQUALITY", true;

// Identify the actual mod-5 subgroup with the independent genus-zero
// database record, allowing a change of representative and recording it.
K5 := sub<A5mat | A5mat![1,2,2,0], A5mat![2,0,2,4]>;
conjugators := [c : c in A5mat | H5^c eq K5];
assert #conjugators gt 0;
cc := Sort([[Integers()!x : x in Eltseq(c)] : c in conjugators])[1];
assert H5^(A5mat!cc) eq K5;
print "MOD5_TO_5_5_0_A_1_CONJUGATOR", cc;
scalars := sub<A5mat | A5mat![2,0,0,2]>;
assert scalars subset H5 and #scalars eq 4;

// Five-letter actions, not an abstract group-name lookup.
rho, arithmetic, ker := CosetAction(G,H);
geometric := sub<arithmetic | [rho(G!g) : g in Generators(G1)]>;
assert Degree(arithmetic) eq 5;
assert arithmetic eq Sym(5) and geometric eq Alt(5);
assert IsTransitive(geometric);
assert #ker eq 64 and Core(G,H) eq ker;
assert #geometric eq 60 and #arithmetic eq 120;
assert not IsNormal(G,H);
rho5, action5, ker5 := CosetAction(A5mat,H5);
assert action5 eq Sym(5) and ker5 eq scalars;
stabilizer := sub<action5 | [rho5(h) : h in Generators(H5)]>;
assert #stabilizer eq 24;
print "ARITHMETIC_FIVE_LETTER_IMAGE", arithmetic;
print "GEOMETRIC_FIVE_LETTER_IMAGE", geometric;
print "PROJECTIVE_MOD5_SUBGROUP_ORDER", #stabilizer;
types := Sort(Setseq({CycleStructure(g) : g in geometric}));
for typ in types do
    print "GEOMETRIC_CYCLE_TYPE_AND_COUNT", typ,
          #[g : g in geometric | CycleStructure(g) eq typ];
end for;

CycleLengths := function(p)
    return Sort(&cat[[pair[1] : i in [1..pair[2]]]
                     : pair in CycleStructure(p)]);
end function;
Profile := function(K1)
    act, perm, kernel := CosetAction(Sambient,K1);
    ps := act(Sambient![0,-1,1,0]);
    pr := act(Sambient![0,-1,1,1]);
    pt := act(Sambient![1,1,0,1]);
    mu := Degree(perm);
    assert ps^2 eq Id(perm) and pr^3 eq Id(perm);
    e2 := #[i : i in [1..mu] | i^ps eq i];
    e3 := #[i : i in [1..mu] | i^pr eq i];
    widths := CycleLengths(pt);
    g := 1+mu/12-e2/4-e3/3-#widths/2;
    assert Denominator(g) eq 1;
    return <mu,e2,e3,widths,Integers()!g>;
end function;
source := Profile(H1); target := Profile(G1);
print "SOURCE_INDEX_E2_E3_WIDTHS_GENUS", source;
print "TARGET_INDEX_E2_E3_WIDTHS_GENUS", target;
assert source eq <480,0,0,[20:i in [1..8]] cat [40:i in [1..8]],33>;
assert target eq <96,0,0,[4:i in [1..8]] cat [8:i in [1..8]],1>;
print "GEOMETRICALLY_CONNECTED_SOURCE_TARGET", true, true;
print "DEFINED_OVER_Q_SOURCE_TARGET_MAP", true, true, true;
print "ALL_GROUP_CHECKS_PASSED";
quit;
