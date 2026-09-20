// Lemma 6.1: modular groups and the unique geometric cubic quotient.
// Original LMFDB generators: see LMFDB_inputs.md (22 July 2026 extract).
// The matrices are row-major. Conjugation means G^c=c^(-1)*G*c.
// See LMFDB_inputs.md for the original records and coordinate conventions.
SetSeed(20260920);
v1,v2,v3 := GetVersion();
print "Magma version", <v1,v2,v3>;
t0 := Cputime();

function Flat(g)
    return [Integers()!g[i,j] : i,j in [1..2]];
end function;

function ReduceGroup(G,n)
    A := GL(2,Integers(n));
    return sub<A | [A!Flat(g) : g in Generators(G)]>;
end function;

function Determinants(G)
    return {Integers()!Determinant(g) : g in G};
end function;

function IsConjugateByEnumeration(A,B,C)
    // All groups used here have ambient order at most 3888.
    for a in A do
        if B^a eq C then return true,Flat(a); end if;
    end for;
    return false,[];
end function;

Hgens := [[16,33,51,10],[36,29,47,54],[44,21,39,38],
          [63,10,34,45],[67,48,30,61]];
Ggens := [[5,15,18,7],[7,0,12,17],[11,6,18,17],
          [19,0,18,5],[19,12,6,11]];
print "H generators modulo 72",Hgens;
print "G generators modulo 24",Ggens;
assert &and[GCD(v[1]*v[4]-v[2]*v[3],72) eq 1 : v in Hgens];
assert &and[GCD(v[1]*v[4]-v[2]*v[3],24) eq 1 : v in Ggens];
A72 := GL(2,Integers(72));
A24 := GL(2,Integers(24));
H := sub<A72 | [A72!v : v in Hgens]>;
G := sub<A24 | [A24!v : v in Ggens]>;
assert #H eq 27648 and #A72 div #H eq 216;
assert #G eq 1024 and #A24 div #G eq 72;
assert A72![-1,0,0,-1] in H;
assert A24![-1,0,0,-1] in G;
assert Determinants(H) eq {a : a in [0..71] | GCD(a,72) eq 1};
assert Determinants(G) eq {a : a in [0..23] | GCD(a,24) eq 1};
print "Orders of H and G",#H,#G;
print "Indices of H and G",#A72 div #H,#A24 div #G;
print "Both contain -I and have full determinant image.";

H8 := ReduceGroup(H,8); H9 := ReduceGroup(H,9);
G8 := ReduceGroup(G,8); G3 := ReduceGroup(G,3);
assert #H8 eq 256 and #H9 eq 108;
assert #G8 eq 256 and #G3 eq 4;
// Injectivity of the CRT map plus equality of orders proves equality with
// the direct product; this checks that no entanglement was discarded.
assert #H eq #H8*#H9 and #G eq #G8*#G3;
print "CRT projection orders H8,H9,G8,G3",#H8,#H9,#G8,#G3;

A8 := GL(2,Integers(8)); A9 := GL(2,Integers(9));
A3 := GL(2,Integers(3));
X8 := sub<A8 | [[3,1,2,7],[3,1,4,3],[3,4,4,5]]>;
Y9 := sub<A9 | [[2,6,6,2],[4,0,0,2]]>;
SplitCartan := sub<A3 | [[1,0,0,2],[2,0,0,2]]>;
ok,c8 := IsConjugateByEnumeration(A8,H8,X8); assert ok;
ok,c9 := IsConjugateByEnumeration(A9,H9,Y9); assert ok;
ok,cg8 := IsConjugateByEnumeration(A8,G8,X8); assert ok;
ok,cg3 := IsConjugateByEnumeration(A3,G3,SplitCartan); assert ok;
assert #SplitCartan eq 4 and #A3 div #SplitCartan eq 12;
print "Projection conjugators to saved groups",c8,c9,cg8,cg3;
print "The level-3 target is the split Cartan of index 12.";

c := A24![16,1,1,17];
assert Determinant(c) ne 0;
// These four matrices generate the full kernel of reduction from 72 to 24.
kernelGens := [[25,0,0,1],[1,24,0,1],[1,0,24,1],[1,0,0,25]];
kernel := sub<A72 | [A72!v : v in kernelGens]>;
assert #kernel eq 81;
assert #A72 div #A24 eq #kernel;
assert &and[Flat(A24!Flat(g)) eq [1,0,0,1] : g in Generators(kernel)];
Gpre0 := sub<A72 | [A72!v : v in Ggens cat kernelGens]>;
assert ReduceGroup(Gpre0,24) eq G;
assert #Gpre0 eq #G*#kernel;
Gpre := Gpre0^(A72!Flat(c));
assert ReduceGroup(Gpre,24) eq G^c;
assert H subset Gpre and #Gpre eq 82944 and Index(Gpre,H) eq 3;
assert ReduceGroup(Gpre,8) eq H8;
Gpre9 := ReduceGroup(Gpre,9);
assert ReduceGroup(Gpre9,3) eq ReduceGroup(H9,3);
assert #Gpre9 eq #H9*3;
assert #Gpre eq #H8*#Gpre9;
assert ReduceGroup(Y9,3) eq SplitCartan;
assert ReduceGroup(H9,3)^(A3!c9) eq SplitCartan;
assert A72![-1,0,0,-1] in Gpre;
assert Determinants(Gpre) eq {a : a in [0..71] | GCD(a,72) eq 1};
print "Compatible target conjugator",Flat(c);
print "Target inverse-image order and relative index",#Gpre,Index(Gpre,H);

Hgeom := H meet SL(2,Integers(72));
Ggeom := Gpre meet SL(2,Integers(72));
assert #Hgeom eq 1152 and #Ggeom eq 3456;
arithMap,arithImage := CosetAction(Gpre,H);
geomMap,geomImage := CosetAction(Ggeom,Hgeom);
assert Degree(arithImage) eq 3 and #arithImage eq 6;
assert Degree(geomImage) eq 3 and #geomImage eq 3;
assert not IsNormal(Gpre,H);
assert IsNormal(Ggeom,Hgeom);
print "Determinant-one orders",#Hgeom,#Ggeom;
print "Arithmetic and geometric three-letter image orders",#arithImage,#geomImage;

H9geom := H9 meet SL(2,Integers(9));
SL9 := SL(2,Integers(9));
assert #H9geom eq 18;
// Exhaust all 648 elements, so no black-box group identification is needed.
N := sub<SL9 | [g : g in SL9 | H9geom^g eq H9geom]>;
assert #N eq 216 and IsNormal(N,H9geom);
quotientMap,deck := CosetAction(N,H9geom);
assert #deck eq 12;
orderThree := [g : g in deck | Order(g) eq 3];
assert #orderThree eq 2;
assert orderThree[2] eq orderThree[1]^2;
H3geom := ReduceGroup(H9geom,3);
intermediate := sub<SL9 | [g : g in SL9 | A3!Flat(g) in H3geom]>;
assert H9geom subset intermediate;
assert IsNormal(intermediate,H9geom) and Index(intermediate,H9geom) eq 3;
print "H9 geometric order, normalizer order, quotient order",#H9geom,#N,#deck;
print "Order-three elements of the quotient",#orderThree;
print "Geometric intermediate relative index",Index(intermediate,H9geom);
// N/H9geom is the geometric deck group of Y over the j-line (the groups
// contain -I, so passage to PSL2 does not change this quotient). Its unique
// order-three subgroup identifies the modular cubic quotient with the
// explicit geometric automorphism (a,v) -> (zeta_3*a,v). The invariant
// rational subfield is Q(a^3,v), a quadratic extension of Q(a^3).
print "All modular-group and unique-cubic-quotient assertions passed.";
print "CPU seconds",Cputime(t0);
